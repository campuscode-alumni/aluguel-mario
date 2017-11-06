require 'rails_helper'

feature 'User search for a property by location' do
  scenario 'successfuly' do
    property_type_1 = create(:property_type, name: 'Apartamento na praia')
    property_type_2 = create(:property_type, name: 'Sitio para festa')
    property = create(:property, property_type: property_type_1,
                      location: 'Juquitiba')
    property_2 = create(:property, property_type: property_type_2,
                        title: 'Guanabara')

    visit root_path

    fill_in 'Busca por Localização', with: 'Juquitiba'
    click_on 'Buscar por Localização'

    expect(page).to have_content property.title
    expect(page).to have_content property.property_type.name
    expect(page).to have_content property.location
    expect(page).to have_content property.area
    expect(page).to have_content property.description
    expect(page).to have_content "R$ 600,00"
    expect(page).to have_content property.photo
    expect(page).not_to have_content property_2.title
  end
  scenario 'and finds nothing' do
    visit root_path
    fill_in 'Busca por Localização', with: 'Juquitiba'
    click_on 'Buscar por Localização'

    expect(page).to have_content 'Nenhum imóvel encontrado'
    expect(current_path).to eq root_path
  end
end
