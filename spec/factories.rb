#encoding: utf-8

require 'factory_girl'

FactoryGirl.define do

  factory :group do
    name        "A Diurno"
    association :discipline
    lessons     :monday    => [:"08:00",:"08:30",:"09:00",:"09:30"],
                :thursday => [:"10:00",:"10:30",:"11:00",:"11:30"]
  end

  factory :discipline do
    name "Bases Matemáticas"
    code
    tpi  "4-0-6"
  end

  sequence :lessons do
    {:monday    => [:"08:00",:"08:30",:"09:00",:"09:30"],
    :thursday => [:"10:00",:"10:30",:"11:00",:"11:30"]}
  end

  sequence :code do |n|
    sprintf("BC%04d",n)
  end

end
