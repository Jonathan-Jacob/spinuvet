module Spina
  module Admin
    class PagesController < AdminController
      before_action :set_locale
      before_action :set_page, only: [:edit, :edit_content, :edit_draft, :edit_template, :update, :destroy, :children, :sort_one]
      before_action :set_tabs

      def index
        add_breadcrumb I18n.t('spina.website.pages'), spina.admin_pages_path

        if params[:resource_id]
          @resource = Resource.find(params[:resource_id])
          @page_templates = Spina::Current.theme.new_page_templates(resource: @resource)
          @pages = @resource.pages.active.roots.includes(:translations).page(params[:page]).per(Spina.config.resource_pages_limit_value).where(deleted: false)
        else
          @pages = Page.active.sorted.roots.main.includes(:translations).where(deleted: false)
          @page_templates = Spina::Current.theme.new_page_templates
        end
      end

      def new
        resource = Resource.find_by(id: params[:resource_id])
        @page = Page.new(view_template: params[:view_template], resource: resource)
      end

      def create
        @page = Page.new(page_params.merge(draft: true, version_counter: {@locale => 1}, version_id: {@locale => 1}))
        if @page.save
          title = @page.translations.where(locale: @locale).first.title
          local_content = JSON.parse(@page.json_attributes_before_type_cast)["#{@locale}_content"]
          PageDraft.create(view_template: @page.view_template.dup, title: title, json_attributes: local_content, locale: @locale, version_id: 1, page_id: @page.id)
          redirect_to spina.edit_admin_page_url(@page, locale: @locale)
        else
          render turbo_stream: turbo_stream.update(view_context.dom_id(@page, :new_page_form), partial: "new_page_form")
        end
      end

      def edit
        add_index_breadcrumb
        add_breadcrumb @page.title
      end

      def edit_content
        @parts = current_theme.view_templates.find do |view_template|
          view_template[:name].to_s == @page.view_template.to_s
        end&.dig(:parts) || []
      end

      def edit_draft
        render layout: false
      end

      def edit_template
        render layout: false
      end

      def update
        Mobility.locale = @locale

        if page_params[:active_page_draft].present?
          page_draft = PageDraft.find(page_params[:active_page_draft])
          updated_attributes = @page.json_attributes.dup
          updated_attributes["#{@locale}_content"] = page_draft.json_attributes.dup
          updated_version_id = @page.version_id.dup
          updated_version_id[@locale] = page_draft.version_id
          @page.update(view_template: page_draft.view_template, json_attributes: updated_attributes, version_id: updated_version_id)
          @page.translations.where(locale: @locale).update(title: page_draft.title)
          flash[:success] = t('spina.pages.saved')

          redirect_to spina.edit_admin_page_url(@page, locale: @locale)
        else
          version_counter = @page.version_counter.dup
          version_id = @page.version_id.dup
          if @page.version_counter.nil?
            version_counter = {@locale => 1}
            version_id = {@locale => 1}
          elsif @page.version_counter[@locale].nil?
            version_counter[@locale] = 1
            version_id[@locale] = 1
          else
            version_counter[@locale] = @page.version_counter[@locale] + 1
            version_id[@locale] = @page.version_counter[@locale] + 1
          end
          versioned_params = page_params.merge(version_counter: version_counter, version_id: version_id)
          if @page.update(versioned_params)
            local_content = JSON.parse(@page.json_attributes_before_type_cast)["#{@locale}_content"]
            title = @page.translations.where(spina_page_id: @page.id).where(locale: @locale).first.title
            PageDraft.create(view_template: @page.view_template.dup, title: title, json_attributes: local_content, locale: @locale, version_id: version_id[@locale], page_id: @page.id)
            if @page.saved_change_to_draft? && @page.live?
              flash[:confetti] = t('spina.pages.published')
            else
              flash[:success] = t('spina.pages.saved')
            end

            redirect_to spina.edit_admin_page_url(@page, locale: @locale)
          else
            add_index_breadcrumb
            Mobility.locale = I18n.locale
            add_breadcrumb @page.title
            flash.now[:error] = t('spina.pages.couldnt_be_saved')
            render :edit, status: :unprocessable_entity
          end
        end
      end

      def sort
        params[:ids].each.with_index do |id, index|
          Page.where(id: id).update_all(position: index + 1)
        end

        flash.now[:info] = t("spina.pages.sorting_saved")
        render_flash
      end

      def sort_one
        current_position = @page.position

        if params[:direction] == "up"
          @bottom_page = @page
          @top_page = @target_page = @page.siblings.where(resource_id: @page.resource_id).sorted.where("position < ?", current_position).last
        else
          @bottom_page = @target_page = @page.siblings.where(resource_id: @page.resource_id).sorted.where("position > ?", current_position).first
          @top_page = @page
        end

        if @target_page
          @page.transaction do
            @page.update(position: @target_page.position)
            @target_page.update(position: current_position)
          end
          flash.now[:info] = t("spina.pages.sorting_saved")
        else
          head :ok
        end
      end

      def children
        @children = @page.children.active.sorted
        render layout: false
      end

      def destroy
        @page.update(deleted: true)
        @page.navigation_items.destroy_all
        flash[:info] = t('spina.pages.deleted')
        redirect_to spina.admin_pages_url
      end

      private

        def set_locale
          @locale = params[:locale] || I18n.default_locale
        end

        def add_index_breadcrumb
          if @page.resource
            add_breadcrumb @page.resource.label, spina.admin_pages_path(resource_id: @page.resource_id), class: 'text-gray-400'
          else
            add_breadcrumb t('spina.website.pages'), spina.admin_pages_path, class: 'text-gray-400'
          end
        end

        def page_params
          params.permit(:active_page_draft, :locale)
          params.require(:page).permit!
        end

        def set_page
          @page = Page.where(deleted: false).find(params[:id])
        end

        def set_tabs
          @tabs = %w[page_content search_engines advanced]
        end

    end
  end
end
