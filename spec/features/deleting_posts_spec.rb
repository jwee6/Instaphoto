require 'rails_helper.rb'

feature 'Delete an existing post' do
	background do
		job = create(:post, caption: 'Abs for days.')

		visit '/'
		find(:xpath, "//a[contains(@href,'posts/1')]").click
		click_link "Edit Post"
	end
	scenario 'can delete post' do 
		click_link "Delete Post"
		expect(page).to have_content("Post deleted")
		expect(page).to_not have_content("Abs for days")
	end
end

