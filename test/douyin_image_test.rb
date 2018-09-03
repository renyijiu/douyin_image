require "test_helper"

class DouyinImageTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DouyinImage::VERSION
  end

  def test_raise_when_no_input_image
    assert_raises do
      DouyinImage.generate('')
    end
  end

  def test_generate_when_no_output_path
    DouyinImage.generate(TEST_FILE)

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_output_path
    DouyinImage.generate(TEST_FILE, './tmp/')

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_offset
    DouyinImage.generate(TEST_FILE, nil, {offset: 10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_negative_offset
    DouyinImage.generate(TEST_FILE, nil, {offset: -10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_part_count
    DouyinImage.generate(TEST_FILE, nil, {part_count: 0})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_negative_part_count
    DouyinImage.generate(TEST_FILE, nil, {part_count: -10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_part_width
    DouyinImage.generate(TEST_FILE, nil, {part_width: 10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_negative_part_width
    DouyinImage.generate(TEST_FILE, nil, {part_width: -10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_part_height
    DouyinImage.generate(TEST_FILE, nil, {part_height: 10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_when_has_negative_part_height
    DouyinImage.generate(TEST_FILE, nil, {part_height: -10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

  def test_generate_success
    DouyinImage.generate(TEST_FILE, nil, { part_height: 10, part_count: 10, part_width: 10, offset: 10})

    assert File.file?(OUTPUT_FILE)
    File.delete(OUTPUT_FILE)
  end

end
