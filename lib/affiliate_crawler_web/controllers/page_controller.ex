defmodule AffiliateCrawlerWeb.PageController do
  use AffiliateCrawlerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def crawl(conn, %{"url" => url}) do
    json(conn, AffiliateCrawler.Crawler.get_links(url))
  end

  def affiliates(conn, _params) do
    json(conn, AffiliateCrawler.Affiliates.all |> Enum.map(&(%{name: &1.name, link: &1.link})))
  end

end
