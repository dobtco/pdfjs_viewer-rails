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

      # We are mounting this engine under a different subdomain from the main app, so the default Rails
      # XFO header breaks the feature. The purpose of this method is to allow pdfs to be embedded
      # by a specific domain (the screendoor domain).

      # There are two ways to control which domains are allowed to embed documents as iframes:
      # X-Frame-Options and Content-Security-Policy. XFO is considered obsolete with CSP.
      # XFO offers the ALLOW-FROM directive, which only allows you to specify one domain. Chrome
      # actively ignores this directive! CSP offers frame-ancestors which lets us provide a list
      # of domains. Only modern browsers support CSP (read: not IE/edge)
      # So we will send both.

      response.headers['X-Frame-Options'] = "ALLOW-FROM #{::Rails.configuration.x.host_with_protocol}"
      response.headers['Content-Security-Policy'] = "frame-ancestors #{::Rails.configuration.x.host_with_protocol}"
    end
  end
end
