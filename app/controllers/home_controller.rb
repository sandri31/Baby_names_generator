# frozen_string_literal: true

class HomeController < ApplicationController
  def new
    $vowels = 'a e i o u y ae ea ai ia ao ua ay ya'.split(' ')
    $consonants = 'b c d f g h j k l m n p q r s t v w x y z ch cl st ss nd tt'.split(' ')

    # What is forbidden anywhere, at start and end
    $forbidden_g = 'zi xy xu wy zu zy zo xi xo za ze xa xe w v tu yy uk yo sx sw sss sn sr np sb sf sg sj sll ty yz yx yn yl yk ym yp yq yr yg yd yc ys yt yb yf yj uu ouou yh uo oo sss sz'.split(' ')
    $forbidden_s = 'y w u tt nn by lc fy z q'.split(' ')
    $forbidden_e = 'j rr ux uz ph thu pp ll nn q ox k z p d b uj ug uc uh um ur uss ust utr st sl eac eaf aj'.split(' ')

    # What is required
    $required_g = 'na'.split(' ')

    # Name size
    $syllables = 2 # Not used (instead we do lines 57-61)
    $length_min = 4
    $length_max = 5

    def generate_associations(g1, g2)
      associations = []

      g1.each do |i|
        g2.each do |j|
          associations << (i + j)
        end
      end

      associations
    end

    def authorized?(name)
      return false if name.length > $length_max
      return false if name.length < $length_min

      $required_g.each do |i|
        return false unless name.include?(i)
      end

      $forbidden_g.each do |i|
        return false if name.include?(i)
      end

      $forbidden_s.each do |i|
        return false if name.start_with?(i)
      end

      $forbidden_e.each do |i|
        return false if name.end_with?(i)
      end

      true
    end

    blocks = []
    blocks[0] = generate_associations($vowels, $consonants)
    blocks[1] = generate_associations($consonants, $vowels)

    names = []
    names = names.concat(generate_associations(blocks[0], blocks[0]))
    names = names.concat(generate_associations(blocks[0], blocks[1]))
    names = names.concat(generate_associations(blocks[1], blocks[0]))
    names = names.concat(generate_associations(blocks[1], blocks[1]))

    names = names.sort.select { |name| authorized?(name) }
    names = names.map(&:capitalize)

    names = names.sort.group_by { |i| i[0] }

    letternumber = []
    newbabynames = []
    names.each do |key, value|
      lettrenumber << "#{key} : #{value.count} noms."
      newbabynames << "#{value.join(', ')} "
    end
    @varglobal = newbabynames
    @titleletter = letternumber
  end
end
