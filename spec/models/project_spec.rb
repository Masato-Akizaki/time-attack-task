# encoding: utf-8
require 'rails_helper'

RSpec.describe Project, type: :model do
  it "is valid with a name" do
    project = Project.new(
      name: "test"
    )
    expect(project).to be_valid
  end

  it "is invalid without a name" do
    project = Project.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("を入力してください")
  end  

  it "is returns a taks's name as a string" do
    project = Project.new(name: "test")
    expect(project.name).to be_a(String) 
  end
end