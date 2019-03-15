FactoryBot.define do
  factory :project, class: 'Project' do
    name { 'Project Runaway' }
    due_date { 1.week.from_now }
  end
end
