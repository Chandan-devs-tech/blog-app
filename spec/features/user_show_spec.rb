require 'rails_helper'

RSpec.feature 'UserShows', type: :feature do
  before :each do
    @user = User.create(
      name: 'Rob',
      bio: 'Software Engineer from India',
      photo: 'https://adorable-kitten.jpg',
      post_counter: 3
    )

    @post1 = Post.create(author_id: @user.id, title: 'First Post', text: 'First', comments_counter: 2, likes_counter: 1)

    @post2 = Post.create(author_id: @user.id, title: 'Second Post', text: 'Second', comments_counter: 0,
                         likes_counter: 2)

    @post3 = Post.create(author_id: @user.id, title: 'Third Post', text: 'Third', comments_counter: 2, likes_counter: 3)
  end

  it 'Display the content of user#show page' do
    visit user_path(@user)
    # I can see the user's profile picture
    expect(page).to have_css("img[src='#{@user.photo}']")
    # I can see the user's username
    expect(page).to have_content(@user.name)
    # I can see the number of posts the user has written
    expect(page).to have_content("Number of posts: #{@user.post_counter}")
    # I can see the user's bio
    expect(page).to have_content(@user.bio)
    # I can see the user's first 3 posts
    expect(page).to have_content(@post3.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post1.title)
    # I can see a button that lets me view all of a user's posts
    expect(page).to have_content('See all posts')
    # When I click a user's post, it redirects me to that post's show page
    click_link @post3.title
    expect(page).to have_current_path(user_post_path(@user, @post3))
    # When I click to see all posts, it redirects me to the user's post's index page
    visit user_path(@user)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
