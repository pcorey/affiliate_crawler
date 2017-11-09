$(document).ready(function() {
    $.get('/affiliates', function(affiliates) {
        $('.affiliates').html(
            affiliates.map(function(affiliate) {
                return $("<li class='affiliate'><a href='" + affiliate.link + "'>" + affiliate.name + '</a></li>');
            })
        );
    });

    $('.search-bar .button').on('click', function() {
        var url = $('.search-bar input').val() || '';
        if (!url) {
            return;
        }
        $('.results-loader').addClass('active');
        $.get('/crawl?url=' + url, function(links) {
            $('.results-loader').removeClass('active');
            console.log('links', links);
            if (!links || !links.length) {
                return $('.results').html($("<p>We couldn't find any monetizable links given that URL!</p>"));
            }
            $('.results').html(
                links.map(function(link) {
                    return $(
                        '<div class="item"> <i class="' +
                            (!link.used ? 'yellow check' : 'green dollar') +
                            ' icon"></i> <div class="content"> <div class="description"><a href="' +
                            link.source +
                            '">This page</a> links to <a href="' +
                            link.target +
                            '">' +
                            link.target +
                            '</a>. Consider using the <a href="' +
                            link.affiliate.link +
                            '">' +
                            link.affiliate.name +
                            '</a> to monetize this link.</div> </div> </div> '
                    );
                })
            );
        });
    });
});
