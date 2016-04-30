require 'rails_helper.rb'

feature 'Creating posts' do 
	scenario 'can create a new post' do
		visit '/'
		click_link 'New Post'
		attach_file('Image',"spec/files/images/yoga.jpg")
		fill_in 'Caption', with: "yoga"
		click_button 'Create Post'
    	expect(page).to have_content("yoga")
    	expect(page).to have_css("img[src*='yoga']")
	end

	it 'needs an image to create a post' do 
		visit '/'
		click_link 'New Post'
		fill_in 'Caption', with: "yoga"
		click_button 'Create Post'
		expect(page).to have_content("Halt, you fiend! You need an image to post here!")
	end

end

feature 'needs to be displayed as individual post after creating' do
	scenario 'can click and view a single post' do
		post = create(:post) 

		visit '/'
		expect(page).to have_content("nofilter")
		#find(:xpath, "//a[contains(@href,'posts/1')]").click
		find(:xpath, "//a[contains(@href, 'posts/1')]").click
		#expect(page.current_path).to eq(post_path(post))
		expect(page.current_path).to eq(root_path)
	end
end


