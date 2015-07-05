require "smalruby"

cat1 = Character.new(costume: "cat2.png", x: 0, y: 182, angle: 0, rotation_style: :left_right)
cat2 = Character.new(costume: "cat3.png", x: 272, y: 1, angle: 0, rotation_style: :left_right)
ball1 = Character.new(costume: "ball6.png", x: 304, y: 220, angle: 225, rotation_style: :left_right)
frog1 = Character.new(costume: "frog1.png", x: 544, y: 183, angle: 180, rotation_style: :left_right)
# こんなこともあろうかと

hit_by = ""
回数 = 0


cat1.on(:key_down, K_UP) do
  self.y += -10
end

cat1.on(:key_down, K_DOWN) do
  self.y += 10
end

cat1.on(:key_down, K_RIGHT) do
  if x <= 224
    self.x += 10
  else
    self.x = 224
  end
end

cat1.on(:key_down, K_LEFT) do
  self.x += -10
end


cat2.on(:start) do
  self.pen_color = [255, 0, 0]
  self.angle = 90
  down_pen
  until reach_wall?
    say(message: "レディ・・・")
    move(20)
    await
  end
  say(message: "ゴー！！！")
  sleep(1)
  loop do
    say(message: 回数)
  end
end


ball1.on(:start) do
  sleep(2)
  loop do
    move(10 + 回数)
    turn_if_reach_wall
    if x >= 608
      cat1.say(message: "勝った！")
      break
    end
    if x <= 0
      cat1.say(message: "負けたー")
      break
    end
  end
end


frog1.on(:start) do
  loop do
    if y >= ball1.y
      self.y += -15
    else
      self.y += 15
    end
  end
end


ball1.on(:hit, cat1) do
  if !(hit_by == "cat1")
    hit_by = "cat1"
    回数 = 回数 + 1
    if Input.key_down?(K_RIGHT)
      self.angle = rand(-45..45)
    else
      turn_x
    end
  end
end


ball1.on(:hit, frog1) do
  if !(hit_by == "frog1")
    hit_by = "frog1"
    回数 = 回数 + 1
    turn_x
  end
end
