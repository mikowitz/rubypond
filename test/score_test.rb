require File.dirname(__FILE__) + "/test_helper"

describe "Score" do
  before do
    @violin = Violin.new do
      n c4, 4
      n d4, 4
      n ef4, 2
      n g4, 4
      n bf3, 2
    end

    @viola = Viola.new do
      n c4, 4
      n bf3, 4
      n g3, 4
      n f3, 4
    end
    
    @cello = Violoncello.new do
      n c3, 4
      n g3, 4
      n bf2, 4
      n ef3, 2
      n d3, 2
    end
  end

  describe "with one part" do
    before do
      violin = @violin
      @s = Score.new do
        part violin
      end
    end
    
    it "should have the correct filename" do
      @s.filename.should == "test_score.ly"
    end
    
    describe "to_s" do
      before do
        @str = @s.to_s
      end
      
      it "should have the lilypond include line" do
        @str.should =~ /\\include \"english\.ly\"/
      end
      
      it "should have the lilypond version line" do
        @str.should =~ /\\version \"#{Rubypond.lilypond_version}\"/
      end
      
      it "should have a part block for each part" do
        @str.should =~ /violin = \\relative c' \{/
      end
      
      it "should have a score segment with the correct parts" do
        @str.should =~ /score \{/
        @str.should =~ /\\new Staff \\violin/
      end
    end
  end

  describe "with two parts" do
    before do
      violin, viola = @violin, @viola
      @s = Score.new "My Test" do
        part violin
        part viola
      end
    end
    
    it "should have the correct filename" do
      @s.filename.should == "my_test.ly"
    end

    describe "to_s" do
      before do
        @str = @s.to_s
      end
      
      it "should have a part block for each part" do
        @str.should =~ /violin = \\relative c' \{/
        @str.should =~ /viola = \\relative c' \{/
      end
      
      it "should have a score segment with the correct parts" do
        @str.should =~ /score \{/
        @str.should =~ /\\new Staff \\violin/
        @str.should =~ /\\new Staff \\viola/
      end
      
    end
  end

  describe "with three parts" do
    before do
      violin, viola, cello = @violin, @viola, @cello
      @s = Score.new "Full Score" do
        part violin
        part viola
        part cello
      end
    end
    
    it "should have the correct filename" do
      @s.filename.should == "full_score.ly"
    end
    
    describe "to_s" do
      before do
        @str = @s.to_s
      end
      
      it "should have a part block for each part" do
        @str.should =~ /violin = \\relative c' \{/
        @str.should =~ /viola = \\relative c' \{/
        @str.should =~ /violoncello = \\relative c \{/
      end
      
      it "should have a score segment with the correct parts" do
        @str.should =~ /score \{/
        @str.should =~ /\\new Staff \\violin/
        @str.should =~ /\\new Staff \\viola/
        @str.should =~ /\\new Staff \\violoncello/
      end

      describe "calling :build" do
        before do
          @s.build
        end

        after do
          File.delete("full_score.ly") if File.exists?("full_score.ly")
          File.delete("full_score.pdf") if File.exists?("full_score.pdf")
        end

        it "should generate the proper .ly and .pdf files" do
          File.exists?("full_score.ly").should be
          File.exists?("full_score.pdf").should be
        end
      end
    end
  end
end


