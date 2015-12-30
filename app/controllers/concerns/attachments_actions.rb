module AttachmentActions
  extend ActiveSupport::Concern

  included do
    include ActionView::Helpers::UrlHelper
  end

  def dnd
    attachable = dnd_params[:attachable_type].constantize.find(dnd_params[:attachable_id])
    attachment_type = dnd_params[:attachment_type]

    # is it's a has_one, get rid of the old one first
    if 'undefined' != attachment_type and not attachable.send(attachment_type).respond_to?(:<<)
      attachable.send(attachment_type).try(:destroy)
    end

    attachment = Attachment.create!(
      attachable: attachable,
      attachment: dnd_params[:file],
      attachment_type: dnd_params[:attachment_type]
    )

    if 'undefined' != dnd_params[:target]
      markup = nil

      url = case dnd_params[:size]
        when 'thumb'
          attachment.attachment.thumb.url
        when 'mini'
          attachment.attachment.mini.url
        when 'link'
          markup = link_to attachment.name, attachment.attachment.url
        else
          attachment.attachment.url
      end

      render json: {
        target: dnd_params[:target],
        url: url,
        markup: markup
      }
    else
      markup = render_to_string(partial: 'shared/attachment', locals: { attachment: attachment.decorate })
      render json: { markup: markup, attachment: attachment.as_json(methods: [:filename]) }
    end
  end

  def destroy
    current_resource.destroy
    render nothing: true
  end

  private

    def dnd_params
      params.permit!
    end

    def current_resource
      Attachment.find_by_id(params[:id])
    end

end
