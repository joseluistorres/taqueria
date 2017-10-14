require "test_helper"

describe TacosController do
  let(:taco) { tacos :one }

  it "gets index" do
    get tacos_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_taco_url
    value(response).must_be :success?
  end

  it "creates taco" do
    expect {
      post tacos_url, params: { taco: { double_tortilla: taco.double_tortilla, meat: taco.meat, name: taco.name, spicy: taco.spicy } }
    }.must_change "Taco.count"

    must_redirect_to tacos_path
  end

  it "shows taco" do
    get taco_url(taco)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_taco_url(taco)
    value(response).must_be :success?
  end

  it "updates taco" do
    patch taco_url(taco), params: { taco: { double_tortilla: taco.double_tortilla, meat: taco.meat, name: taco.name, spicy: taco.spicy } }
    must_redirect_to taco_path(taco)
  end

  it "destroys taco" do
    expect {
      delete taco_url(taco)
    }.must_change "Taco.count", -1

    must_redirect_to tacos_path
  end
end
