require 'rails_helper'

RSpec.feature 'PostIndices', type: :feature do
  before :each do
    @user = User.create(name: 'Bala', bio: 'Doctor from Turkey',
                        photo: 'https://img.freepik.com/kitten.jpg', post_counter: 2)
    @post1 = Post.create(author_id: @user.id, title: 'Post #1',
                         text: 'First', comments_counter: 1, likes_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Post #2',
                         text: 'Second', comments_counter: 1, likes_counter: 0)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id,
                               text: 'First comment')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post2.id,
                               text: 'Second comment')
  end

  it 'Shows the content of the post#index page' do
    visit user_posts_path(@user)
    # I can see the user's profile picture
    expect(page).to have_css("img[src='#{@user.photo}']")
    # I can see the user's username
    expect(page).to have_content(@user.name)
    # I can see the number of posts the user has written
    expect(page).to have_content("Number of posts: #{@user.post_counter}")
    # I can see a post's title
    expect(page).to have_content(@post1.title)
    # I can see some of the post's body
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.text)
    # I can see the first comments on a post
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
    # I can see how many comments a post has
    expect(page).to have_content("Comments: #{@post1.comments_counter}")
    expect(page).to have_content("Comments: #{@post2.comments_counter}")
    # I can see how many likes a post has
    expect(page).to have_content("Like: #{@post1.likes_counter}")
    expect(page).to have_content("Like: #{@post2.likes_counter}")
    # I can see a section for pagination if there are more posts than fit on the view
    expect(page).to have_content('Pagination')
    # When I click on a post, it redirects me to that post's show page
    click_link @post1.title
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end
end
