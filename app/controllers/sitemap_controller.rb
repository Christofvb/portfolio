class SitemapController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    @pages = [
      { path: root_path,            priority: "1.0", changefreq: "monthly" },
      { path: curriculum_vitae_path, priority: "0.9", changefreq: "monthly" },
      { path: portfolio_path,       priority: "0.8", changefreq: "weekly"  }
    ]
    @locales = %i[fr en nl]
    @updated_at = Date.today.iso8601

    respond_to do |format|
      format.xml { render layout: false }
    end
  end
end
