defmodule AffiliateCrawlerWeb.PageController do
  use AffiliateCrawlerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
