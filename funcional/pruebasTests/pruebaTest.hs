-- pruebaTest
import Test.Hspec


runTests = hspec $ do
	describe "Tests con números:" $ do
		it "1 + 1 es 2" $ do
	1 + 1 `shouldBe` 2
