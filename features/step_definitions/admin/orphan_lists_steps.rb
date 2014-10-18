Given(/^I visit the new orphan list page for partner "([^"]*)"$/) do |partner|
  partner_id = Partner.find_by_name(partner).id
  visit upload_admin_partner_orphan_lists_path(partner_id)
end

And(/^I upload the "([^"]*)" file$/) do |file|
  attach_file 'pending_orphan_list_spreadsheet', "spec/fixtures/#{file}"
end

Then(/^I should( not)? find pending orphan list "([^"]*)" in the database$/) do |negative, list|
  pending_list = PendingOrphanList.find_by_spreadsheet_file_name list
  negative ? (expect(pending_list).to eq nil) : (expect(pending_list).not_to eq nil)
end

And(/^provinces and orphan statuses have been seeded$/) do
  Province.create(name: 'Damascus & Rif Dimashq', code: 11)
  Province.create(name: 'Aleppo', code: 12)
  Province.create(name: 'Homs', code: 13)
  Province.create(name: 'Hama', code: 14)
  Province.create(name: 'Latakia', code: 15)
  Province.create(name: 'Deir Al-Zor', code: 16)
  Province.create(name: 'Daraa', code: 17)
  Province.create(name: 'Idlib', code: 18)
  Province.create(name: 'Ar Raqqah', code: 19)
  Province.create(name: 'Al Ḥasakah', code: 20)
  Province.create(name: 'Tartous', code: 21)
  Province.create(name: 'Al-Suwayada', code: 22)
  Province.create(name: 'Al-Quneitera', code: 23)
  Province.create(name: 'Outside Syria', code: 29)
  OrphanStatus.create(name: 'Active', code: 1)
  OrphanStatus.create(name: 'Inactive', code: 2)
  OrphanStatus.create(name: 'On Hold', code: 3)
  OrphanStatus.create(name: 'Under Revision', code: 4)
  OrphanSponsorshipStatus.create(name: 'Unsponsored',          code: 1)
  OrphanSponsorshipStatus.create(name: 'Sponsored',            code: 2)
  OrphanSponsorshipStatus.create(name: 'Previously Sponsored', code: 3)
  OrphanSponsorshipStatus.create(name: 'On Hold',              code: 4)
end