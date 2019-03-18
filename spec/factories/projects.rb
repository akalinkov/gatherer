FactoryBot.define do
  factory :project, class: 'Project' do
    name { 'Project Runaway' }
    due_date { 1.week.from_now }

    trait :soon do
      due_date { 1.day.from_now }
    end

    trait :later do
      due_date { 1.month.from_now }
    end
  end
end
