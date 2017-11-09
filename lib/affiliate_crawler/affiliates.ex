defmodule AffiliateCrawler.Affiliates do

  def all do
    [
      %{
        name: "Amazon Affiliate Program",
        link: "https://affiliate-program.amazon.com/home",
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
        name: "Wealthfront Referral Program",
        link: "https://support.wealthfront.com/hc/en-us/articles/209353126-Referrals-What-s-the-Wealthfront-Invite-Program-",
        test: ~r/wealthfront\.com/,
        used: ~r/wlth\.fr/
      }
    ]
  end

end
