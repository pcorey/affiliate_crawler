defmodule AffiliateCrawlerWeb.PageController do
  use AffiliateCrawlerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def crawl(conn, %{"url" => url}) do
    links = AffiliateCrawler.Crawler.get_links(url)
    |> Enum.map(&AffiliateCrawler.Affiliates.get_affiliate_link/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.map(&(%{&1 | source: to_string(&1.source), target: to_string(&1.target)}))
    json(conn, links)
  end

  def affiliates(conn, _params) do
    affiliates = AffiliateCrawler.Affiliates.all
    |> Enum.map(&(%{name: &1.name, link: &1.link}))
    json(conn, affiliates)
  end

end
