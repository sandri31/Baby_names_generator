# frozen_string_literal: true

# BabyNameSuggestion is a module that provides methods for generating and
# filtering baby names. It contains a list of common vowels and consonants,
# and a set of rules for determining which names are allowed and which are
# forbidden.
#
# @author JMG Harry and modified by Symitsh
module BabyNameGenerator
  VOWELS = %w[a e i o u y ae ea ai ia ao ua ay ya].freeze
  CONSONANTS = %w[b c d f g h j k l m n p q r s t v w x y z ch cl st ss nd tt].freeze
  FORBIDDEN_GLOBAL = %w[zi xy xu wy zu zy zo xi xo za ze xa xe w v tu yy uk yo sx sw sss sn sr np sb sf sg sj sll ty yz
                        yx yn yl yk ym yp yq yr yg yd yc ys yt yb yf yj uu ouou yh uo oo sss sz].freeze
  FORBIDDEN_START = %w[y w u tt nn by lc fy z q].freeze
  FORBIDDEN_END = %w[j rr ux uz ph thu pp ll nn q ox k z p d b uj ug uc uh um ur uss ust utr st sl eac eaf aj].freeze
  REQUIRED_GLOBAL = %w[na].freeze
  MIN_LENGTH = 4
  MAX_LENGTH = 5

  def self.generate_combinations(list1, list2)
    list1.product(list2).map(&:join)
  end

  def self.ends_with?(string, substring)
    string[-substring.length, substring.length] == substring
  end

  def self.starts_with?(string, substring)
    string[0, substring.length] == substring
  end

  def self.authorized?(name, starts_with: nil, ends_with: nil)
    valid_length?(name) &&
      contains_required_chars?(name) &&
      !forbidden_char_present?(name) &&
      (starts_with.nil? || starts_with?(name, starts_with)) &&
      (ends_with.nil? || ends_with?(name, ends_with))
  end

  def self.valid_length?(name)
    name.length >= MIN_LENGTH && name.length <= MAX_LENGTH
  end

  def self.contains_required_chars?(name)
    REQUIRED_GLOBAL.all? { |char| name.include?(char) }
  end

  def self.forbidden_char_present?(name)
    FORBIDDEN_GLOBAL.any? { |char| name.include?(char) } ||
      FORBIDDEN_START.any? { |char| starts_with?(name, char) } ||
      FORBIDDEN_END.any? { |char| ends_with?(name, char) }
  end

  def self.generate_baby_generator(starts_with: nil, ends_with: nil)
    blocks = []
    blocks[0] = generate_combinations(VOWELS, CONSONANTS)
    blocks[1] = generate_combinations(CONSONANTS, VOWELS)

    names = []
    names.concat(generate_combinations(blocks[0], blocks[0]))
    names.concat(generate_combinations(blocks[0], blocks[1]))
    names.concat(generate_combinations(blocks[1], blocks[0]))
    names.concat(generate_combinations(blocks[1], blocks[1]))
    names = names.sort.select { |name| authorized?(name, starts_with: starts_with, ends_with: ends_with) }
    names = names.map(&:capitalize)
    baby_names = names.sort.group_by { |name| name[0] }
  end
end
