require_relative '../app/bitmap_editor'

describe BitmapEditor do
  let(:bitmap){  BitmapEditor.new() }



  context "with invalid input" do
    context "I  " do
      it "should return empty matrix" do
        bitmap.cmd = ''
        bitmap.cmd_options = ''
        expect(bitmap.matrix).to eq []
      end
    end
    context "G 5 6 7 M" do
      it "should return empty matrix" do
        bitmap.cmd = 'G'
        bitmap.cmd_options = [5,6,7,'M']
        expect(bitmap.matrix ).to eq []
      end
    end
    context "I 400 400" do
      it "should raise an error" do
        bitmap.cmd = 'I'
        bitmap.cmd_options = [400, 400]
        expect{bitmap.create_image}.to raise_error(RangeError,"Invalid Matrix. Pixel co-ordinates should be pair of integers: a column number between 1 and 250, and a row number between 1 and 250")
      end
    end
    context "I foo bar" do
      it "should raise an error" do
        bitmap.cmd = 'I'
        bitmap.cmd_options = ["foo", "bar"]
        expect{bitmap.create_image}.to raise_error ArgumentError
      end
    end
  end
  context "with valid input" do
    context "I 5 6" do

      it "should create a new 5 x 6 image with all pixels coloured white (O)" do
        bitmap.cmd_options = [5, 6]
        result = [
          ["O","O","O","O","O"],
          ["O","O","O","O","O"],
          ["O","O","O","O","O"],
          ["O","O","O","O","O"],
          ["O","O","O","O","O"],
          ["O","O","O","O","O"],
        ]
        expect(bitmap.create_image).to eq result

      end

      context "with command " do

        before(:each) do
          bitmap.cmd_options = [5, 6]
          bitmap.create_image
        end

        context "L 2 3 A" do
          it "should colour the pixel (2,3) with colour A." do
            bitmap.cmd_options = [2, 3, 'A']
            result = [
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","A","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
            ]
            bitmap.color_image_pixel
            expect(bitmap.matrix).to eq result
          end
        end

        context "V 2 3 6 W" do
          it "should draw a vertical segment of colour W in column 2 between rows 3 and 6 (inclusive)." do
            bitmap.cmd_options = [2, 3, 6,'W']
            result = [
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","W","O","O","O"],
              ["O","W","O","O","O"],
              ["O","W","O","O","O"],
              ["O","W","O","O","O"],
            ]
            bitmap.draw_vertical_segment
            expect(bitmap.matrix).to eq result
          end
        end

        context "H 3 5 2 Z" do
          it "should draw a horizontal segment of colour Z in row 2 between columns 3 and 5 (inclusive)" do
            bitmap.cmd_options = [3, 5, 2,'Z']
            result = [
              ["O","O","O","O","O"],
              ["O","O","Z","Z","Z"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
            ]
            bitmap.draw_horizontal_segment
            expect(bitmap.matrix).to eq result
          end
        end

        context "C" do
          it "should clear the table, setting all pixels to white (O)" do
            result = [
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
            ]
            bitmap.clear_image
            expect(bitmap.matrix).to eq result
          end
        end

        context "S" do
          it "should show the contents of the current image" do
            result = [
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
              ["O","O","O","O","O"],
            ]
            expect(bitmap.matrix).to eq result
          end
        end

        context "X" do
          it "should terminate the session"
        end

        context "?" do
          it "should show display help text"
        end

      end
    end
  end

end
