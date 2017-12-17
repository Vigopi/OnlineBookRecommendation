$('button').click(function(e) {
    if ($(this).hasClass('grid')) {
        $('#container ul').removeClass('list').addClass('grid');
    }
    else if($(this).hasClass('list')) {
        $('#container ul').removeClass('grid').addClass('list');
    }
});