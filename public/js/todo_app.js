$(document).ready(function() {

    // event handler for clicking checkboxes
    $('input.done-checkbox').click(function() {
        var ticked = $(this).is(':checked'); // check if this checkbox is ticked or unticked
        $li = $(this).parents('li');
        var taskId = $li.data('id'); // find the id ID of the task for the checkbox that was clicked
        var action = ticked ? '/complete' : '/uncomplete'; // pick action based on whether checkbox is ticked
        $.post('/todos/' + taskId + action, null, function() {
            $li.toggleClass('completed');
        });
    });

    // event handler for deleting tasks
    $('a.delete-link').click(function() {
        /// find the ID of the task for this delete link
        $li = $(this).parents('li');
        var itemId = $li.data('id');
        $.ajax({
            method: 'DELETE',
            url: '/todos/' + itemId
        }).done(function(data) {
            // animation for removing the item after it's been deleted
            $li.slideUp(200);
        });
    });

});