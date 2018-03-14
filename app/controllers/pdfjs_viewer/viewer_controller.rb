module PdfjsViewer
  class ViewerController < PdfApplicationController
    layout false

    after_action :allow_embedding_in_iframe

    def full
    end

    def minimal
    end

    def reduced
    end

    private

    def allow_embedding_in_iframe
      # By default Rails sends the 'X-Frame-Options: SAMEORIGIN' header with responses.
      # This means that the response can only be rendered on an iframe whose parent has the same
      # origin as the response.
      # Chrome doesn't support the ALLOW-FROM directive so we can't use X-Frame-Options
      # to whitelist just our intended origin.
      # Instead we just remove the X-Frame-Options header altogether so from the browser perspective
      # the repsonse can be embedded on any page.
      response.headers.except! 'X-Frame-Options'
    end
  end
end
