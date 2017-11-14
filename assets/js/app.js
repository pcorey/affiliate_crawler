function truncate(text, max) {
    return text.length > max ? text.substring(0, max - 3) + '...' : text;
}

$(document).ready(function() {
    $.get('/affiliates', function(affiliates) {
        $('.affiliates').html(
            affiliates.map(function(affiliate) {
                return $("<li class='affiliate'><a href='" + affiliate.link + "'>" + affiliate.name + '</a></li>');
            })
        );
    });

    $('.search-bar').on('submit', function(e) {
        e.preventDefault();
        var url = $('.search-bar input').val() || '';
        if (!url) {
            return;
        }
        if (history.pushState) {
            let newUrl = `${window.location.protocol}//${window.location.host}${window.location.pathname}?${url}`;
            window.history.pushState({ path: newUrl }, '', newUrl);
        }
        ga('send', {
            hitType: 'event',
            eventCategory: 'Crawler',
            eventAction: 'crawl',
            eventLabel: url
        });
        $('#mc_embed_signup_results').hide();
        $('.results').html('');
        $('.results-loader').addClass('active');
        $.get('/crawl?url=' + url, function(links) {
            $('.results-loader').removeClass('active');
            if (!links || !links.length) {
                return $('.results').html(
                    $("<p class='not-found'>We couldn't find any monetizable links given that URL!</p>")
                );
            }
            $('#mc_embed_signup_results').show();
            $('.results').html(
                links.map(function(link) {
                    return $(
                        '<div class="item"> <i class="' +
                            (!link.affiliate.used ? 'yellow dollar' : 'green check') +
                            ' icon"></i> <div class="content"> <div class="description"><a href="' +
                            link.source +
                            '">This page</a> links to <a href="' +
                            link.target +
                            '">' +
                            truncate(link.target, 50) +
                            '</a>' +
                            (!link.affiliate.used
                                ? '. Consider using the <a href="' +
                                      link.affiliate.link +
                                      '">' +
                                      link.affiliate.name +
                                      '</a> to monetize this link.'
                                : ', and it\'s already monetized through the <a href="' +
                                      link.affiliate.link +
                                      '">' +
                                      link.affiliate.name +
                                      '</a>.') +
                            '</div> </div> </div> '
                    );
                })
            );
        }).fail(function() {
            $('.results-loader').removeClass('active');
            return $('.results').html($("<p class='not-found'>We had a problem crawling that URL!</p>"));
        });
        return false;
    });

    let url = document.location.search.substr(1);
    if (url && $('.search-bar input').val() != url) {
        $('.search-bar input').val(url);
        $('.search-bar').trigger('submit');
    }
});
