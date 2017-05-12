$('.comment_section_feed<%= @micropost.id %>').append('<%= j render @comment, micropost: @micropost %>');
$('#comment_form_<%= @micropost.id %>').val('');
