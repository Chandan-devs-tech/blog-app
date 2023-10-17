require 'rails_helper'

RSpec.feature 'PostShows', type: :feature do
  before :each do
    @user = User.create(name: 'Marial', bio: 'Engineer from US',
                        photo: 'https://adorable-kitten.jpg',
                        post_counter: 2)

    @post = Post.create(author_id: @user.id, title: 'Post #1',
                        text: 'First', comments_counter: 3, likes_counter: 0)

    @comment1 = Comment.create(user_id: @user.id, post_id: @post.id, text: 'First comment')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post.id, text: 'Second comment')
    @comment3 = Comment.create(user_id: @user.id, post_id: @post.id, text: 'Third comment')
  end

  it 'Shows the content of the post#show page' do
    visit user_post_path(@user, @post)
    # I can see the post's title
    expect(page).to have_content(@post.title)
    # I can see who wrote the post
    expect(page).to have_content(@user.name)
    # I can see how many comments it has
    expect(page).to have_content("Comments: #{@post.comments_counter}")
    # I can see how many likes it has
    expect(page).to have_content("Like: #{@post.likes_counter}")
    # I can see the post body
    expect(page).to have_content(@post.text)
    within('.list-of-comments') do
      # I can see the username of each commentor
      expect(page).to have_content(@user.name)
      # I can see the comment each commentor left
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
    end
  end
end
