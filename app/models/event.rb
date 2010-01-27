class Event < ActiveRecord::Base
  attr_accessible :date, :name, :properties

  # Other ideas
  #=> boundary_buster...
  #=> metaphysical_exploration...
  bitmask :properties, :as => {
    1 => :romantic,
    2 => :fun,
    3 => :exciting,
    4 => :envigorating,
    5 => :eye_opening,
    6 => :enlightening,
    7 => :hard,
    7 => :emotionally_challenging,
    8 => :one_off,
    }.values

  # bitmask :properties, :as => {
  #   1 => :snowball_fight,
  #   2 => :great_talk,
  #   3 => :all_nighter,
  #   4 => :explore_the_town,
  #   5 => :romantic_encounter,
  #   6 => :throwing_disk,
  #   7 => :game_fest
  #   }.values


end

class RomanticEncounter < Event
end