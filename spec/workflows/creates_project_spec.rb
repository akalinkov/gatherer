require 'rails_helper'

describe CreatesProject do

  it 'should create a project given a name' do
    creator = CreatesProject.new(name: 'Project Runway')
    creator.build
    expect( creator.project.name ).to eq( 'Project Runway' )
  end
end