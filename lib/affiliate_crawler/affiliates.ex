defmodule AffiliateCrawler.Affiliates do

  def all do
    [
      %{
        name: "Amazon Affiliate Program",
        link: "https://affiliate-program.amazon.com/ref=as_li_ss_tl?ie=UTF8&linkCode=ll2&tag=east5th-20&linkId=63282cc153e252c42371187a8fccafa5",
        test: ~r/amazon\.com/,
        used: ~r/amzn\.to|tag=/
      },
      %{
        name: "Coinbase Referral Program",
        link: "https://www.coinbase.com/invite_friends",
        test: ~r/coinbase\.com/,
        used: ~r/join/
      },
      %{
        name: "DigitalOcean Referral Program",
        link: "https://www.digitalocean.com/referral-program/",
        test: ~r/digitalocean\.com/,
        used: ~r/do\.co/
      },
      %{
        name: "iHerb Rewards Program",
        link: "https://www.iherb.com/info/rewards?rcode=PET9171",
        test: ~r/iherb\.com/,
        used: ~r/rcode=/
      },
      %{
        name: "Wealthfront Referral Program",
        link: "https://support.wealthfront.com/hc/en-us/articles/209353126-Referrals-What-s-the-Wealthfront-Invite-Program-",
        test: ~r/wealthfront\.com/,
        used: ~r/wlth\.fr/
      },
    ]
  end

  def get_affiliate_link(link) do
    target = to_string(link.target)
    all()
    |> Enum.filter(&(target =~ &1.test))
    |> Enum.map(&(Map.put_new(link, :affiliate, %{name: &1.name, link: &1.link, used: target =~ &1.used})))
    |> List.first
  end

end
