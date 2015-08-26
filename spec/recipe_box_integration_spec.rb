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
    click_button 'Delete'
    expect(page).not_to have_content 'Mojito'
  end
end
