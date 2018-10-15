require 'rails_helper'

describe CreatesProject do

  let(:creator) { CreatesProject.new( name: 'Project Runway', task_string: task_string )}

  describe 'initialization' do
    let( :task_string ) { '' }
    it 'creates a project given a name' do
      creator.build
      expect(creator.project.name).to eq('Project Runway')
    end
  end

  describe 'task string parsing' do
    let(:tasks) { creator.convert_string_to_tasks }

    it 'with an empty string' do
      let(:task_string) { '' }
      specify { expect( tasks ).to be_empty }
    end

    it 'with a single string' do
      creator = CreatesProject.new(name: 'Project Runway', task_string: 'Start Things')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start Things', size: 1)
    end

    it 'handles a single string with size' do
      creator = CreatesProject.new(name: 'Project Runway', task_string: 'Start Things:3')
      tasks = creator. convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start Things', size: 3)
    end

    it 'handles a single string with size zero' do
      creator = CreatesProject.new( name: 'Project Runway', task_string: 'Start Things:0')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start Things', size: 1)
    end

    it 'handles a single string with malformed size' do
      creator = CreatesProject.new( name: 'Project Runway', task_string: 'Start Things:')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start Things', size: 1)
    end

    it 'handles a single string with negative size' do
      creator = CreatesProject.new( name: 'Project Runway', task_string: 'Start Things:-1')
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: 'Start Things', size: 1)
    end

    it 'handles multiple tasks' do
      creator = CreatesProject.new( name: 'Project Runway', task_string: 'Start Things:3\nEndThings:2')
      tasks = creator.convert_sting_to_tasks
      expect(tasks.size).to eq(2)
      expect(tasks).to match(
                           [
                               an_object_having_attributes(title: 'Start Things', size: 3),
                               an_object_having_attributes(title: 'End Things', size: 2)
                           ]
                       )
    end

    it 'attaches tasks to the project' do
      creator = CreatesProject.new( name: 'Project Runway', task_string: 'Start Things:3\nEnd Things:2')
      creator.create
      expect(creator.project.tasks.size).to eq(2)
      expect(creator.project).not_to be_a_new_record
    end
  end
end

