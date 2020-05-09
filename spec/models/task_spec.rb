require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a name, detail" do
    task = Task.new(
      name: "test",
      detail: "this task is test"
    )
    expect(task).to be_valid
  end

  it "is invalid without a name" do
    task = Task.new(name: nil)
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end  

  it "is returns a taks's name as a string" do
    task = Task.new(name: "test")
    expect(task.name).to be_a(String) 
  end

end
