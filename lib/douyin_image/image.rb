
module DouyinImage
  class Image

    def generate(file_path, output_path, options={})
      offset = options.delete(:offset) || 8

      im = Vips::Image.new_from_file(file_path)
      im_r = im * [1, 0, 0] # 获取 R 值数据
      im_gb = im * [0, 1, 1] # 获取 GB 值数据

      im_r = im_r.embed(offset, offset, im.width, im.height)

      # 获取最终图片数据
      target_im = im_r.add(im_gb)
      target_im = random_part_offset(target_im, options)
      target_im.write_to_file(output_path)
    end

    private

    def random_part_offset(image, options={})
      parts = get_random_parts(image, options)

      parts.each do |part|
        x, y, width, height = part

        crop_mode = [:none, :centre, :entropy, :attention].sample
        im = image.smartcrop(width, height, interesting: crop_mode)

        image = image.draw_image(im, x, y, mode: :set)
      end

      image
    end

    # 随机获取图片切片位置以及大小信息
    def get_random_parts(image, options={})
      # 图片切割份数
      part_count = options.fetch(:part_count, rand(5..10))
      tmp_height = (image.height / part_count).to_i

      part_count.times.map do |index|
        x = rand(1...image.width)
        y = rand(1...tmp_height) + index * tmp_height

        part_width = options.fetch(:part_width, rand(10..30))
        part_height = options.fetch(:part_height, rand(10..30))

        [x, y, part_width, part_height]
      end
    end

  end
end