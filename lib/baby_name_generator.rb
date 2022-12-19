module BabyNameGenerator
  VOWELS = %w[a e i o u y ae ea ai ia ao ua ay ya]
  CONSONANTS = %w[b c d f g h j k l m n p q r s t v w x y z ch cl st ss nd tt]
  FORBIDDEN_GLOBAL = %w[zi xy xu wy zu zy zo xi xo za ze xa xe w v tu yy uk yo sx sw sss sn sr np sb sf sg sj sll ty yz
                        yx yn yl yk ym yp yq yr yg yd yc ys yt yb yf yj uu ouou yh uo oo sss sz]
  FORBIDDEN_START = %w[y w u tt nn by lc fy z q]
  FORBIDDEN_END = %w[j rr ux uz ph thu pp ll nn q ox k z p d b uj ug uc uh um ur uss ust utr st sl eac eaf aj]
  REQUIRED_GLOBAL = %w[na]
  MIN_LENGTH = 4
  MAX_LENGTH = 5

  def self.generate_combinations(list1, list2)
    list1.product(list2).map { |combination| combination.join }
  end

  def self.authorized?(name)
    valid_length?(name) && contains_required_chars?(name) && !forbidden_char_present?(name)
  end

  def self.valid_length?(name)
    name.length >= MIN_LENGTH && name.length <= MAX_LENGTH
  end

  def self.contains_required_chars?(name)
    REQUIRED_GLOBAL.all? { |char| name.include?(char) }
  end

  def self.forbidden_char_present?(name)
    FORBIDDEN_GLOBAL.any? { |char| name.include?(char) } ||
      FORBIDDEN_START.any? { |char| name.start_with?(char) } ||
      FORBIDDEN_END.any? { |char| name.end_with?(char) }
  end

  def self.generate_baby_names
    blocks = []
    blocks[0] = generate_combinations(VOWELS, CONSONANTS)
    blocks[1] = generate_combinations(CONSONANTS, VOWELS)

    names = []
    names.concat(generate_combinations(blocks[0], blocks[0]))
    names.concat(generate_combinations(blocks[0], blocks[1]))
    names.concat(generate_combinations(blocks[1], blocks[0]))
    names.concat(generate_combinations(blocks[1], blocks[1]))
    names = names.sort.select { |name| authorized?(name) }
    names = names.map(&:capitalize)
    names = names.sort.group_by { |name| name[0] }

    name_count = []
    baby_names = []
    names.each do |first_char, names_with_same_first_char|
      name_count << "#{first_char} : #{names_with_same_first_char.count} names"
      baby_names << "#{names_with_same_first_char.join(', ')} "
    end

    [baby_names, name_count]
  end
end
