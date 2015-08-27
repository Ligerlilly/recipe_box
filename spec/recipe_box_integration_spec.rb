require 'spec_helper'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'recipe_box path', { type: :feature } do
  it 'can create a new recipe' do
    visit '/'
    click_link 'See amazing recipes now!'
    fill_in 'name', with: 'Mojito'
    fill_in 'ingredients', with: 'Gin, mint, sugar'
    fill_in 'instructions', with: 'Muddle'
    click_button 'Submit'
    expect(page).to have_content 'Mojito'
  end

  it 'can update the recipe' do
    @recipe = Recipe.create({name: "mojito", instructions: "muddle", ingredients: "mint, gin and sugar"})
    visit '/recipes'
    click_link "#{@recipe.name}"
    click_link 'Update Recipe'
    fill_in 'name', with: 'Corndog'
    fill_in 'ingredients', with: 'Corndog'
    fill_in 'instructions', with: 'Corndog'
    click_button 'Submit'
    expect(page).to have_content 'Corndog'
  end

  it 'will remove a recipe' do
    @recipe = Recipe.create({name: "Mojito", instructions: "muddle", ingredients: "mint, gin and sugar"})
    visit '/recipes'
    click_link "#{@recipe.name}"
    click_link 'delete'
    expect(page).not_to have_content 'Mojito'
  end

  it 'will add a rating to a recipe' do
    @recipe = Recipe.create({name: "Mojito", instructions: "muddle", ingredients: "mint, gin and sugar", rating: 0})
    visit '/recipes'
    click_link "#{@recipe.name}"
    click_link 'edit'
    select '5 stars', from: 'rating'
    click_button 'Submit'
    expect(page).to have_content '5 stars'
  end
end

describe 'tag path', { type: :feature } do
  it 'can create a tag associated with a recipe' do
    @recipe = Recipe.create({name: "Mojito", instructions: "muddle", ingredients: "mint, gin and sugar"})
    visit '/recipes'
    click_link "#{@recipe.name}"
    click_link 'Add Tag'
    select 'Cocktail', from: 'tag_name'
    click_button 'Submit'
    expect(page).to have_content 'Mojito'
    expect(page).to have_content 'Cocktail'
  end

  it 'will remove a tag' do
    @recipe = Recipe.create({name: "mojito", instructions: "muddle", ingredients: "mint, gin and sugar"})
    @tag = Tag.create({name: "drink"})
    @recipe.tags.push(@tag)
    visit "/recipes/#{@recipe.id}"
    expect(page).to have_content "drink"
    click_link "Delete Tags"
    expect(page).not_to have_content "drink"
  end

  it 'will update a tag' do
    @recipe = Recipe.create({name: "mojito", instructions: "muddle", ingredients: "mint, gin and sugar"})
    @tag = Tag.create({name: "drink"})
    @recipe.tags.push(@tag)
    visit "/recipes/#{@recipe.id}"
    click_link "#{@tag.name}"
    select 'Cocktail', from: 'tag_name'
    click_button 'Submit'
    expect(page).to have_content "Cocktail"
    expect(page).not_to have_content "drink"
  end

end
