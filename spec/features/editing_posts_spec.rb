require 'rails_helper.rb'

feature 'Editing posts' do 
	background do
		job = create(:post)

		visit '/'
		my_link = find(:xpath, "//a[contains(@href,'posts/1')]")
		puts "my Link"
		my_link.click
		click_link "Edit Post"
	end

	scenario 'can edit an existing post' do
		fill_in 'Caption', with: "Oh god, you weren’t meant to see this picture!"
		click_button 'Update Post'

		expect(page).to have_content("Post updated hombre.")
		expect(page).to have_content("Oh god, you weren’t meant to see this picture!")
	end

	it "won't update a post without an image" do 
		attach_file('Image', 'spec/files/images/yoga.jpg')
		click_button "Edit Post"

		expect(page).to have_content("Something is wrong with your form")
	end

end