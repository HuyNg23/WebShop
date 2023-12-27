-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 07, 2023 lúc 06:19 AM
-- Phiên bản máy phục vụ: 10.4.21-MariaDB
-- Phiên bản PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shop_web`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product2`
--

CREATE TABLE `product2` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` bigint(255) NOT NULL,
  `description` text NOT NULL,
  `type_product` varchar(255) NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product2` (`id`, `product_name`, `price`, `description`, `type_product`, `gender`, `image_url`) VALUES
(1, 'Áo sơ mi lụa thêu hoa', 625000, 'Áo sơ mi lụa thêu hoa màu hồng.Mix áo cùng chân váy hoặc quần đều là sự lựa chọn hoàn hảo cho nàng đi làm và đi chơi.', 'Áo sơ mi ', 'Nữ', 'a1.jpg'),
(2, 'Áo sơ mi Tencel', 795000, 'Áo sơ mi cổ đức, dáng oversize với thiết kế tay ngắn kèm dây buộc nơ tạo kiểu. Dọc thân áo là khuy cài kim loại thanh lịch. Áo xẻ tà 2 bên.', 'Áo sơ mi', 'Nữ', 'a2.jpg'),
(3, 'Áo sơ mi họa tiết ren', 763000, 'Chất liệu sợi vải mềm mịn, thoáng mát được tuyển chọn cẩn thận để đảm bảo sự thoải mái tuyệt đối khi mặc vào. Kiểu dáng áo dài thướt tha sẽ tôn lên vẻ đẹp sang trọng', 'Áo sơ mi', 'Nữ', 'a3.jpg'),
(4, 'Áo sơ mi tay xếp', 763000, 'Áo sơ mi cổ đức vải lụa trơn. Thiết kế dấu khuy tinh tế. Ống tay được xếp tầng và bo nhẹ. Dáng xuông và dài vừa phải.', ' Áo sơ mi', 'Nữ', 'a4.jpg'),
(5, 'Áo sơ mi dây rút eo', 595000, 'Áo sơ mi này có thể dễ dàng kết hợp với nhiều trang phục khác nhau. Khi kết hợp cùng quần jean và giày sneakers, bạn sẽ có một trang phục đơn giản, trẻ trung và năng động', 'Áo sơ mi', 'Nữ', 'a5.jpg'),
(6, 'Áo sơ mi tay xếp', 763000, 'Áo sơ mi cổ đức vải lụa trơn. Thiết kế dấu khuy tinh tế. Ống tay được xếp tầng và bo nhẹ. Dáng xuông và dài vừa phải', 'Áo sơ mi', 'Nữ', 'a6.jpg'),
(7, 'Áo sơ mi đính nơ ngọc trai', 475000, 'Áo sơ mi cổ đức. Chất liệu voan. Tay ngắn và phồng nhẹ, bo ở đầu ống. Phía trước là khuy bấm kim loại. Trên cổ áo được đính nơ ngọc trai. Cổ áo, viền tay áo và viền khuy được phối cùng một màu', 'Áo sơ mi', 'Nữ', 'a7.img'),
(8, 'Áo sơ mi in họa tiết hoa', 625000, 'Áo sơ mi dài tay thiết kế cổ đức, dáng suông với chất liệu vải thô dễ dàng phối đồ theo nhiều cách khác nhau phù hợp với sự thay đổi của thời tiết', 'Áo sơ mi', 'Nữ', 'a8.jpg'),
(9, 'Áo sơ mi lụa khuy kiểu', 833000, 'Áo sử dụng chất liệu lụa cao cấp, mềm mại, nhẹ nhàng mang đến cảm giác mặc thoải mái phù hợp mọi thời tiết', ' Áo sơ mi', 'Nữ', 'a9.jpg'),
(10, 'Áo sơ mi kẻ chất lụa', 745000, 'Áo sơ mi dáng ôm, thân áo có độ đứng. Thiết kế cổ đức. Phía trước có 2 túi hộp phối cùng khuy kim loại. Tại phần khủy tay có khuy để cài cố định khi gập ống tay. Tà áo dáng đuôi tôm xẻ ở 2 bên', 'Áo sơ mi', 'Nữ', 'a10.jpg'),
(11, 'Áo thun đính hoa', 325000, 'Áo thun cổ tròn, tay ngắn. Dáng dài suông. Mặt trước trang trí bông hoa tạo kiểu.Chất liệu thun mang đặc tính co dãn, thấm hút mồ hôi vượt trội mang đến vẻ đẹp trẻ trung, năng động cho người mặc', 'Áo thun', 'Nữ', 'at1.jpg'),
(12, 'Áo thun phối chữ LOVE', 230000, 'Áo chất thun, cổ tròn, tay ngắn, dáng suông. Trên vai được phối cùng phụ kiện đính kết từ voan và ngọc trai', 'Áo thun', 'Nữ', ' at2.jpg'),
(13, 'Áo thun trơn cổ đức khuy ngọc trai', 345000, 'Áo thun cổ đức, cài bằng hàng khuy ngọc trai phía trước. Kiểu dáng, màu sắc basic, dáng suông cơ bản', 'Áo thun', 'Nữ', 'at3.jpg'),
(14, 'Áo thun IN QUOTE OMBRE', 230000, 'Áo thun dáng suông, độ dài vừa phải, không có ống tay, vai nối dài, cổ tròn. Phía trước áo được in câu quote với phối màu ombre', ' Áo thun', 'Nữ', 'at4.jpg'),
(15, 'Áo thun flower', 325000, 'Áo được trang trí với hoạ tiết in hoa nổi trước ngực, tạo nên điểm nhấn và giúp thiết kế trở nên độc lạ hơn. Với màu sắc nhẹ nhàng và hoạ tiết tươi sáng', 'Áo thun', 'Nữ', 'at5.jpg'),
(16, 'Áo thun len', 250000, 'Áo len sát nách được thiết kế với chất liệu len chọn lọc cao cấp, tạo nên hình ảnh mềm mại và sang trọng. Điểm nhấn nằm ở họa tiết kẻ ngang đầy ấn tượng trên nền màu áo đổi lập', 'Áo thun', 'Nữ', 'at6.jpg'),
(17, 'Áo thun trơn cổ sen', 270000, 'Áo thun cổ sen nữ tính, tay áo nhún phồng nhẹ nhàng. Áo cài bằng hàng khuy cùng màu.Thiết kế áo form suông, thoải mái, khả năng mix & match được cùng nhiều items khác nhau', 'Áo thun', 'Nữ', 'at7.jpg'),
(18, 'Chân váy xếp ly dáng xuông', 370000, 'Chân váy sở hữu thiết kế xếp ly tinh tế tạo ra những uyển chuyển thướt tha khi di chuyển. Với chất liệu vải lụa mềm mại, chân váy không chỉ mang đến sự thoải mái khi mặc mà còn tạo nên sự sang trọng, quý phải', ' Chân váy', 'Nữ', 'cv1.jpg'),
(19, 'Chân váy xòe phối ly', 525000, 'Kiểu dáng xoè nhẹ về đuôi và thiết kế xếp ly tạo sự phóng khoáng và trẻ trung cho người mặc. Điểm nhấn của thiết kế là hàng khuy ngọc đính kèm ở cạp váy, tăng thêm sự sang trọng và thu hút', 'Chân váy', 'Nữ', 'cv2.jpg'),
(20, 'Chân váy chữ A phối viền hoa nổi ', 460000, ' Chiếc váy có phom dáng chữ A, mang đến vẻ thanh lịch và trang nhã cho người diện. Điểm nhấn đặc biệt của chiếc váy chính là viền hoa may nổi bật và thu hút bằng vải ren trên thân váy', ' Chân váy', 'Nữ', ' cv3.jpg'),
(21, 'Chân váy midi phối ren', 585000, 'Thiết kế của chân váy được may từ hai lớp vải tinh tế. Ngoài là lớp ren hoa may nổi được điểm trên thân váy. Bên trong chân váy là một lớp vải lót mềm mại, tiếp xúc êm ái với làn da người mặc. Vải lót tạo lớp che chắn nhẹ nhàng và định hình dáng váy', ' Chân váy', 'Nữ', 'cv4.jpg'),
(22, 'Chân váy lệch tà phối dây rút', 725000, 'Chân váy 2 lớp dáng dài qua đầu gối, tà cắt lệch lạ mắt phối cùng dây kéo rút nhúm 2 bên tạo kiểu. Chất liệu vải lụa mềm mại, có độ bóng nhẹ,ít nhăn', 'Chân váy', 'Nữ', 'cv5.jpg'),
(23, 'Chân váy bút chì 2 lớp', 675000, 'Chân váy kiểu dáng basic là một item thời trang công sở mang tới cho các cô nàng có ưu thế chiều cao một vóc dáng xinh đẹp và đẳng cấp tuyệt vời', ' Chân váy', ' Nữ', 'cv6.jpg'),
(24, 'Chân váy bò chữ A xẻ trước ', 735000, 'Chân váy bò dáng chữ A. Có 5 túi. Cạp cao có đỉa. Xẻ cao phía trước. Gấu kiểu xổ chỉ. Cài bằng dây kéo và khuy kim loại', ' Chân váy', 'Nữ', 'cv7.jpg'),
(25, 'Quần dài ống rộng', 435000, 'Quần dài ống rộng, độ dài qua mắt cá chân. Quần cạp cao, có khóa kéo bên hông', 'Quần', 'Nữ', ' q1.jpg'),
(26, 'Quần bò rách may viền', 495000, 'Quần jean ống đứng, dáng suông, độ dài đến mắt cá chân. Phía trước có may viền sọc cách điệu. Bên đùi phải tạo kiểu rách. 2 túi sau mông. Đai quần có khuy cài và đỉa quần', 'Quần', 'Nữ', 'q2.jpg'),
(27, 'Quần sooc nữ trơn', 320000, 'Quần sooc nữ, suông ống đứng. Độ dài ngang đùi. Có 2 túi 2 bên. Cài bằng móc khóa ẩn và dây kéo phía trước', 'Quần', 'Nữ', 'q3.jpg'),
(28, 'Quần ống loe nhấn xẻ', 495000, 'Quần dáng ống loe, dài chấm gót. Phần hông ôm nhẹ và loe dần về cuối. Gấu quần xẻ nhẹ ở 2 bên tạo điểm nhấn. Quần có đai cao cùng khuy cài', 'Quần', 'Nữ', 'q4.jpg'),
(29, 'Quần baggy phối khuy đai', 595000, 'Quần baggy dáng cơ bản. Phần trên có độ rộng nhẹ, phần dưới bo dần và giữ dáng ống đứng. Phía trước có 2 túi chéo, phía sau có 2 túi hộp. Quần có khuy cài và khóa kéo', 'Quần', 'Nữ', 'q5.jpg'),
(30, 'Quần jeans túi vuông ', 565000, 'Hách dáng cùng mẫu quần jeans ống suông mới nhất.Có thể dễ dàng mix với nhiều kiểu áo khác nhau để thể hiện vẻ đẹp tự tin, cá tính của mình', 'Quần', 'Nữ', 'q5.jpg'),
(31, 'Túi da xách tay', 399000, 'Mẫu túi xách tay size medium, chất liệu da PU. Bên trong lót vải, có 1 ngăn ẩn. Quai xách cố định, không tháo rời và điều chỉnh được', 'Túi', 'Nữ', ' t1.jpg'),
(32, 'Túi da đeo tay', 895000, 'Túi xách size medium, chất liệu da PU. Bên trong lót vải, có 1 ngăn ẩn. Quai đeo vai cố định, không tháo rời và điều chỉnh được. Có túi nhỏ đi kèm', ' Túi', 'Nữ', 't2.jpg'),
(33, 'Túi mini dáng dài', 395000, ' Túi dáng mini cho nàng thích sự nhỏ nhắn đáng yêu. Túi da màu đen basic, nắp nam châm tiện lợi phù hợp với nhiều kiểu trang phục', 'Túi', 'Nữ', 't3.jpg'),
(34, 'Túi xách Hobo', 745000, ' Túi đeo vai Medium. Thân túi hình chữ nhật, chất liệu da pu giả da động vật. Có quai đeo vai không tháo rời được. Lót vải bên trong có 1 ngăn nhỏ có khóa. Đóng mở bằng khóa kéo', 'Túi', 'Nữ', 't4.jpg'),
(35, 'Túi xách hình hộp', 399000, 'Thiết kế túi hình hộp chữ nhật kèm quai đeo vai có thể tháo rời. Hoạt tiết hình khối được cắt ghép tỉ mỉ tạo sự độc đáo. Form túi rộng tiện lợi giúp nàng đựng được nhiều đồ cơ bản', 'Túi', 'Nữ', 't5.jpg'),
(36, 'Túi Mini Bag quai xách ', 199000, 'Thiết kế đứng phomThiết kế đứng phom,dây đeo chéo da đi kèm, có thể tháo rời. Bên trong lót vải, có 1 ngăn lớn kéo khóa bên trong 1 ngăn phụ', 'Túi', 'Nữ', 't6.jpg'),
(37, 'Gìay mũi nhọn', 199000, 'Giày mũi nhọn, Gót nhỏ cao 3cm. 1 dây quai ngang móc cài. Phối 2 màu tạo kiểu.', 'Giày', 'Nữ', ' g1.jpg'),
(38, 'Giày cao gót đế nhựa', 149000, 'Dép cao gót phối đế nhựa trong suốt. Có 1 quai ngang và vặn tạo kiểu. Gót cao 9 cm. Mũi bo vuông', 'Giày', 'Nữ', 'g2.jpg'),
(39, 'Giày búp bê Retro', 1190000, 'Giày búp bê mũi bít mang kiểu dáng cổ điển. Gót vuông cao 3cm. Chất liệu da trơn bóng, đai có đính ngọc trai mang lại vẻ thanh lịch', 'Giày', 'Nữ', 'g3.jpg'),
(40, ' Giày cao gót mũi nhọn', 1590000, 'Giày mũi nhọn, Gót nhỏ cao 6cm. 1 dây quai ngang móc cài. Chất liệu da PU tổng hợp cao cấp nhập khẩu có độ bóng nhẹ, mềm mịn, chống nấm mốc', 'Giày', 'Nữ', 'g4.jpg'),
(41, 'Giày cao gót phối lưới', 1590000, 'Giày cao gót mũi nhọn, phối lưới, gót bọc da. Gót cao 7cm', 'Giày', 'Nữ', 'g5.jpg'),
(42, 'Áo thun nam phối túi hộp', 345000, 'Áo thun trơn cổ tròn basic, Chất áo thun thoáng mát cho các chàng trai vận động thoải mái', 'Áo thun', 'Nam', 'an1.jpg'),
(43, 'Áo thun IN QUOTE', 345000, 'Áo thun dáng cơ bản, ôm nhẹ nhưng không bó, có động rộng nhất định. Tay ngắn, cổ tròn', 'Áo thun', 'Nam', 'an2.jpg'),
(44, 'Áo thun nam SAVE ', 357000, 'Áo thun cổ tròn. Tay áo dài bo gấu. Chữ khác màu 1 bên ngực.Sử dụng chất liệu thun mềm mại, thông thoáng và co giãn tối ưu, tạo cảm giác thoải mái khi mặcÁo thun cổ tròn. Tay áo dài bo gấu. Chữ khác màu 1 bên ngực', 'Áo thun', 'Nam', 'an3.jpg'),
(45, 'Áo thun nam kẻ ngang', 237000, 'Áo thun cổ tròn viền chun co giãn. Tay dài. Vải kẻ ngang làm điểm nhấn. Dáng áo Regular', 'Áo thun', 'Nam', 'an4.jpg'),
(46, 'Áo thun nam tay ngắn', 245000, 'Áo thun nam cổ tròn, tay ngắn. Dáng xuông. Trang trí hình và 1 túi vuông bên ngực', 'Áo thun', 'Nam', 'an5.jpg'),
(47, 'Áo thun nam ngắn tay kẻ ngang', 208000, 'Áo thun cổ tròn, tay ngắn. Họa tiết kẻ ngang và in hình cây tạo điểm nhấn. Dáng áo xuông', 'Áo thun ', 'Nam', 'an6.jpg'),
(48, 'Áo thun City Rider', 370000, 'Áo thun nam cổ tròn, tay ngắn. Trang trí hình và chữ sinh động mặt trước. Dáng áo suông cơ bản', 'Áo thun', 'Nam', 'an7.jpg'),
(49, 'Áo khoác gió cổ mũ ', 545000, 'Áo khoác gió 2 lớp phom suông rộng, giúp người mặc thoải mái trong từng cử động, nhưng đồng thời vẫn đảm bảo vừa vặn về số đo vai, độ dài tay, áo', 'Áo khoác', 'Nam', 'ak1.jpg'),
(50, 'Áo khoác dạ nam dáng dài', 1107000, 'Áo khoác dạ cổ 2 ve khoét chữ K. Tay dài có 3 khuy trang trí. 2 túi vuông có nắp 2 bên. Dáng áo suông dài. Cài bằng hàng khuy phía trước', 'Áo khoác', 'Nam', ' ak2.jpg'),
(51, 'Áo khoác blazer nam', 807000, 'Áo khoác blazer cổ 2 ve khoét chữ K. Tay dài. Vai đệm. 2 nắp túi bên tà và 1 viền túi giả bên ngực. Có hàng 6 khuy phía trước. Sau lưng có đai kèm khuy', ' Áo khoác', 'Nam', 'ak3.jpg'),
(52, 'Áo khoác len Cardigan', 417000, 'Áo khoác len của nam cổ V, tay dài. Có 2 túi vuông 2 bên không nắp, gấu bo viền co giãn. Độ ôm vừa vặn quanh ngực để tạo cảm giác thoải mái khi mặc', 'Áo khoác', 'Nam', 'ak4.jpg'),
(53, 'Áo khoác giả da cổ tàu', 687000, 'Áo da cổ tàu thiết kế dáng suông, dài tay, sử dụng khóa kéo kim loại mặt trước', 'Áo khoác ', 'Nam', 'ak5.jpg'),
(54, 'Áo khoác dạ dài tay', 807000, 'Áo khoác dạ cổ 2 ve, tay dài. Có 2 túi chéo viền gấp trang trí. Cài bằng hàng khuy đôi phía trước', 'Áo khoác', 'Nam', 'ak6.jpg'),
(55, 'Áo khoác thun cổ phối màu', 1250000, 'Áo khoác thun nam. Cổ viền màu khác màu. Tay áo dài bo gấu. Có 2 túi chéo. Cài bằng dây kéo khóa kim loại phía trước', 'Áo khoác', ' Nam', 'ak7.jpg'),
(56, 'Quần gió cạp chun', 595000, 'Quần gió nam cạp chun co giãn có dây kéo rút. 2 túi chéo. Dáng quần Regular', 'Quần', 'Nam', 'qn1.jpg'),
(57, 'Quần bò Skinny', 575000, 'Quần bò dáng skinny ôm nhẹ. Phía trước được đánh bạc sáng màu. Thiết kế năng động và trẻ trung, phù hợp cho những dịp đi chơi của chàng', 'Quần', 'Nam', ' qn2.jpg'),
(58, 'Quần dạ dáng Regular', 357000, 'Quần dạ kẻ dáng Regular cạp có đỉa kèm dây kéo rút. 2 túi chéo và 2 viền túi có nắp phía sau. Họa tiết kẻ caro nổi bật', 'Quần', 'Nam', 'qn3.jpg'),
(59, 'Quần dài dáng slim', 408000, 'Quần dáng slim, ôm nhẹ, ống đứng. Phía trước có khuy cài lệch và khóa kéo. Trên đai quần có đỉa để luồn thắt lưng', 'Quần', 'Nam', ' qn4.jpg'),
(60, ' Quần sooc jean nam', 308000, 'Quần sooc bò màu đen dáng regular fit. Có 5 túi. Cạp sử dụng khóa và khuy kim loại, mặt trước rách cá tính. Màu đen hiện đại, phù hợp với thời trang dạo phố', 'Quần', 'Nam', 'qn5.jpg'),
(61, ' Quần kaki dáng slim', 388000, 'Quần dài khaki kiểu dáng Slim, đai quần có đỉa, cạp được phối chun co giãn 2 bên', 'Quần', ' Nam', ' qn6.jpg'),
(62, 'Quần tây nam vai kẻ', 417000, 'Quần dài ống suông. Cài phía trước bằng khóa kéo và khuy. Họa tiết kẻ trẻ trung, năng động', 'Quần', 'Nam', 'qn7.jpg'),
(63, 'Giày lười quai ngang', 449000, 'Giày nam thiết kế kiểu giày lười, quai ngang có dây đan và khóa kim loại. Đế giày cao 3cm chắc chắn, chống trơn trượt. Đường may chi tiết, tỉ mỉ theo tiêu chuẩn ', 'Giày', 'Nam', 'gn1.jpg'),
(64, 'Giày thể thao da PU', 1050000, ' Đế giày cao 3cm chắc chắn, chống trơn trượt. Đường may chi tiết, tỉ mỉ theo tiêu chuẩn', 'Giày', 'Nam', ' gn2.jpg'),
(65, 'Giày Da Microfiber', 1190000, 'Thân giày được làm từ chất liệu Da Microfiber.Lớp lót bằng vải chuyên dụng giúp thoáng mát đôi chân.Đế giày được làm từ cao su non tự nhiên', 'Giày', 'Nam', 'gn3.jpg'),
(66, 'Giày da trơn buộc dây', 1590000, 'Giày nam thiết kế thắt dây. Đế giày cao 3cm chắc chắn, chống trơn trượt. Đường may chi tiết, tỉ mỉ theo tiêu chuẩn', 'Giày', 'Nam', 'gn4.jpg'),
(67, 'Giày lười nam đục lỗ ', 1190000, 'Giày lười nam họa tiết lỗ. Đế giày chắc chắn, chống trơn trượt. Từng đường may kép tỉ mỉ, chắc chắn chạy quanh giày. Chất liệu da bò thật cùng thiết kế cách điệu với họa tiết lỗ ở thân giày tạo cảm giác nam tính. Mũi giày tròn, bo viền chắc chắn', ' Giày', ' Nam', 'gn5.jpg');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
