# encoding: utf-8
require 'rails_helper'

RSpec.describe Project, type: :model do
  user = FactoryBot.create(:user)
  it "is valid with a name" do
    project = user.projects.build(
      name: "test",
      user_id: user.id
    )
    expect(project).to be_valid
  end

  it "is invalid without a name" do
    project = user.projects.build(name: nil, user_id: user.id)
    project.valid?
    expect(project.errors[:name]).to include("を入力してください")
  end  

  it "is returns a taks's name as a string" do
    project = user.projects.build(name: "test", user_id: user.id)
    expect(project.name).to be_a(String) 
  end
end