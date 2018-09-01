require "vips"
require "douyin_image/image"
require "douyin_image/version"

module DouyinImage

  class << self

    # generate Douyin style image with the input image
    #
    # @param file_path String - image file path
    # @param output_path String - output directory, default: same with input file
    # options:
    #   offset: the R channel image offset, default: 8
    #   part_count: the small part's count, default: rand(5..10)
    #   part_width: the small part's width, default: rand(10..30)
    #   part_height: the small part's height, default: rand(10..30)
    #
    # Example:
    #   DouyinImage.generate('./test.jpg', './test/', {offset: 10})
    #
    def generate(file_path, output_path=nil, options={})
      raise ArgumentError, 'File not exist, please check the file path' unless File.file?(file_path)
      output_path = get_output_filepath(file_path, output_path)

      Image.new.generate(file_path, output_path, options)
      puts "图片生成完成，去看看吧😊！#{output_path}"
    end

    protected

    def get_output_filepath(file_path, output_path)
      output_path ||= File.dirname(file_path)
      raise ArgumentError, 'Output path is not valid' unless File.directory?(output_path)

      basename = File.basename(file_path)
      filename = basename.gsub(/^(.+?)(\.\w+)$/, '\1_douyin\2')

      file = File.join(output_path, filename)
      raise ArgumentError, "#{file}, file is exist, change another directory" if File.file?(file)

      file
    end

  end

end
