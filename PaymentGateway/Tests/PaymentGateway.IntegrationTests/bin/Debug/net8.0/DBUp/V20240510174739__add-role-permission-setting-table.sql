-- ----------------------------
-- Table structure for role_permission_setting
-- ----------------------------
DROP TABLE IF EXISTS `role_permission_setting`;
CREATE TABLE `role_permission_setting` (
                              `id` bigint NOT NULL,
                              `role_type` tinyint NOT NULL,
                              `permission_id` bigint NOT NULL,
                              `create_at` datetime(6) NOT NULL,
                              `update_at` datetime(6) NOT NULL,
                              `is_delete` bit(1) NOT NULL DEFAULT b'0',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_permission_setting
-- ----------------------------

BEGIN;
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457041875973,0,8348143697724421,'2024-05-10 10:08:12.094616','2024-05-10 10:08:12.094699',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457074775045,0,8348143697789959,'2024-05-10 10:08:12.094806','2024-05-10 10:08:12.094806',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457107674117,0,8348143697789962,'2024-05-10 10:08:12.094806','2024-05-10 10:08:12.094806',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457140442117,0,8348143697789965,'2024-05-10 10:08:12.094806','2024-05-10 10:08:12.094807',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457173275653,0,8348143697789968,'2024-05-10 10:08:12.094807','2024-05-10 10:08:12.094807',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457206109189,0,8348143697789971,'2024-05-10 10:08:12.094807','2024-05-10 10:08:12.094807',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457238942725,0,8348143697789974,'2024-05-10 10:08:12.094807','2024-05-10 10:08:12.094807',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457271710725,0,8348143697789977,'2024-05-10 10:08:12.094807','2024-05-10 10:08:12.094807',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457304544261,0,8348143697789980,'2024-05-10 10:08:12.094808','2024-05-10 10:08:12.094808',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457403044869,0,8348143697789989,'2024-05-10 10:08:12.094808','2024-05-10 10:08:12.094808',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457468711941,0,8348143697789995,'2024-05-10 10:08:12.094808','2024-05-10 10:08:12.094809',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457501611013,0,8348143697789998,'2024-05-10 10:08:12.094809','2024-05-10 10:08:12.094809',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457534444549,0,8348143697790001,'2024-05-10 10:08:12.094809','2024-05-10 10:08:12.094809',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457567278085,0,8348143697790004,'2024-05-10 10:08:12.094809','2024-05-10 10:08:12.094809',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457600177157,0,8348143697790007,'2024-05-10 10:08:12.094809','2024-05-10 10:08:12.094809',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457633010693,0,8348143697790010,'2024-05-10 10:08:12.094809','2024-05-10 10:08:12.094810',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457665909765,0,8348143697790013,'2024-05-10 10:08:12.094810','2024-05-10 10:08:12.094810',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457698743301,0,8348143697790016,'2024-05-10 10:08:12.094810','2024-05-10 10:08:12.094810',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457731576837,0,8348143697790019,'2024-05-10 10:08:12.094810','2024-05-10 10:08:12.094810',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457797243909,0,8348143697790025,'2024-05-10 10:08:12.094813','2024-05-10 10:08:12.094813',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457830077445,0,8348143697790028,'2024-05-10 10:08:12.094813','2024-05-10 10:08:12.094813',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457862910981,0,8348143697790031,'2024-05-10 10:08:12.094813','2024-05-10 10:08:12.094813',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457928512517,0,8348143697790037,'2024-05-10 10:08:12.094814','2024-05-10 10:08:12.094814',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457961346053,0,8348143697790040,'2024-05-10 10:08:12.094814','2024-05-10 10:08:12.094814',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727457994179589,0,8348143697790043,'2024-05-10 10:08:12.094814','2024-05-10 10:08:12.094814',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458027013125,0,8348143697790046,'2024-05-10 10:08:12.094814','2024-05-10 10:08:12.094814',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458059846661,0,8348143697790049,'2024-05-10 10:08:12.094814','2024-05-10 10:08:12.094814',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458191246341,0,8348143697790061,'2024-05-10 10:08:12.094815','2024-05-10 10:08:12.094815',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458224079877,0,8348143697790064,'2024-05-10 10:08:12.094815','2024-05-10 10:08:12.094815',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458256913413,0,8348143697790067,'2024-05-10 10:08:12.094815','2024-05-10 10:08:12.094816',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458289746949,0,8348143697790070,'2024-05-10 10:08:12.094816','2024-05-10 10:08:12.094816',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458322580485,0,8348143697790073,'2024-05-10 10:08:12.094816','2024-05-10 10:08:12.094816',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458355414021,0,8348143697790076,'2024-05-10 10:08:12.094816','2024-05-10 10:08:12.094816',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458519516165,0,8348143697790091,'2024-05-10 10:08:12.094817','2024-05-10 10:08:12.094817',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458650981381,1,8348143697724421,'2024-05-10 10:08:12.094818','2024-05-10 10:08:12.094818',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458683814917,1,8348143697789959,'2024-05-10 10:08:12.094818','2024-05-10 10:08:12.094818',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458716648453,1,8348143697789962,'2024-05-10 10:08:12.094818','2024-05-10 10:08:12.094818',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458749481989,1,8348143697789965,'2024-05-10 10:08:12.094818','2024-05-10 10:08:12.094818',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458782315525,1,8348143697789968,'2024-05-10 10:08:12.094819','2024-05-10 10:08:12.094819',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458815149061,1,8348143697789971,'2024-05-10 10:08:12.094819','2024-05-10 10:08:12.094819',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458847982597,1,8348143697789974,'2024-05-10 10:08:12.094819','2024-05-10 10:08:12.094819',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458880816133,1,8348143697789977,'2024-05-10 10:08:12.094819','2024-05-10 10:08:12.094819',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727458913649669,1,8348143697789980,'2024-05-10 10:08:12.094819','2024-05-10 10:08:12.094819',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459012150277,1,8348143697789989,'2024-05-10 10:08:12.094820','2024-05-10 10:08:12.094820',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459077817349,1,8348143697789995,'2024-05-10 10:08:12.094820','2024-05-10 10:08:12.094820',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459110650885,1,8348143697789998,'2024-05-10 10:08:12.094820','2024-05-10 10:08:12.094820',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459143418885,1,8348143697790001,'2024-05-10 10:08:12.094821','2024-05-10 10:08:12.094821',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459176252421,1,8348143697790004,'2024-05-10 10:08:12.094821','2024-05-10 10:08:12.094821',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459209085957,1,8348143697790007,'2024-05-10 10:08:12.094821','2024-05-10 10:08:12.094821',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459241919493,1,8348143697790010,'2024-05-10 10:08:12.094821','2024-05-10 10:08:12.094821',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459274753029,1,8348143697790013,'2024-05-10 10:08:12.094821','2024-05-10 10:08:12.094821',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459307521029,1,8348143697790016,'2024-05-10 10:08:12.094822','2024-05-10 10:08:12.094822',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459340354565,1,8348143697790019,'2024-05-10 10:08:12.094822','2024-05-10 10:08:12.094822',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459406087173,1,8348143697790025,'2024-05-10 10:08:12.094822','2024-05-10 10:08:12.094822',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459438920709,1,8348143697790028,'2024-05-10 10:08:12.094822','2024-05-10 10:08:12.094822',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459471688709,1,8348143697790031,'2024-05-10 10:08:12.094822','2024-05-10 10:08:12.094822',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459537355781,1,8348143697790037,'2024-05-10 10:08:12.094823','2024-05-10 10:08:12.094823',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459570189317,1,8348143697790040,'2024-05-10 10:08:12.094823','2024-05-10 10:08:12.094823',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459602957317,1,8348143697790043,'2024-05-10 10:08:12.094823','2024-05-10 10:08:12.094823',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459635790853,1,8348143697790046,'2024-05-10 10:08:12.094823','2024-05-10 10:08:12.094823',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459767190533,1,8348143697790061,'2024-05-10 10:08:12.094824','2024-05-10 10:08:12.094824',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459800024069,1,8348143697790064,'2024-05-10 10:08:12.094824','2024-05-10 10:08:12.094824',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459832857605,1,8348143697790067,'2024-05-10 10:08:12.094824','2024-05-10 10:08:12.094824',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459865691141,1,8348143697790070,'2024-05-10 10:08:12.094825','2024-05-10 10:08:12.094825',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459898524677,1,8348143697790073,'2024-05-10 10:08:12.094825','2024-05-10 10:08:12.094825',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727459931358213,1,8348143697790076,'2024-05-10 10:08:12.094825','2024-05-10 10:08:12.094825',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727460161258501,2,8348143697724421,'2024-05-10 10:08:12.094826','2024-05-10 10:08:12.094826',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727460194092037,2,8348143697789959,'2024-05-10 10:08:12.094826','2024-05-10 10:08:12.094826',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727460226925573,2,8348143697789962,'2024-05-10 10:08:12.094827','2024-05-10 10:08:12.094827',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727460259693573,2,8348143697789965,'2024-05-10 10:08:12.094827','2024-05-10 10:08:12.094827',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (8727460292527109,2,8348143697789968,'2024-05-10 10:08:12.094827','2024-05-10 10:08:12.094827',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032197513413637,0,8348143697789983,'2024-07-03 05:46:38.646229','2024-07-03 05:46:38.648187',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032197513413638,1,8348143697789983,'2024-07-03 05:46:38.646251','2024-07-03 05:46:38.648187',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032197513413639,2,8348143697789983,'2024-07-03 05:46:38.646252','2024-07-03 05:46:38.648187',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032197947589637,0,8348143697789986,'2024-07-03 05:46:45.273674','2024-07-03 05:46:45.273938',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032197947589638,1,8348143697789986,'2024-07-03 05:46:45.273675','2024-07-03 05:46:45.273938',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032197947589639,2,8348143697789986,'2024-07-03 05:46:45.273675','2024-07-03 05:46:45.273939',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032199020348421,0,8348143697789992,'2024-07-03 05:47:01.642435','2024-07-03 05:47:01.642552',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032199020348422,1,8348143697789992,'2024-07-03 05:47:01.642436','2024-07-03 05:47:01.642551',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032199020348423,2,8348143697789992,'2024-07-03 05:47:01.642436','2024-07-03 05:47:01.642552',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032210098619397,0,8348143697790022,'2024-07-03 05:49:50.683158','2024-07-03 05:49:50.683265',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032219590001669,0,8348143697790034,'2024-07-03 05:52:15.510681','2024-07-03 05:52:15.510783',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032219590001670,1,8348143697790034,'2024-07-03 05:52:15.510682','2024-07-03 05:52:15.510783',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032219590001671,2,8348143697790034,'2024-07-03 05:52:15.510682','2024-07-03 05:52:15.510783',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032227183789061,0,8348143697790052,'2024-07-03 05:54:11.382646','2024-07-03 05:54:11.382846',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032227183789062,1,8348143697790052,'2024-07-03 05:54:11.382646','2024-07-03 05:54:11.382845',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032227183789063,2,8348143697790052,'2024-07-03 05:54:11.382646','2024-07-03 05:54:11.382846',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032227902063621,0,8348143697790055,'2024-07-03 05:54:22.342601','2024-07-03 05:54:22.342709',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032227902063622,1,8348143697790055,'2024-07-03 05:54:22.342601','2024-07-03 05:54:22.342708',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032227902063623,2,8348143697790055,'2024-07-03 05:54:22.342601','2024-07-03 05:54:22.342709',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032228433691653,0,8348143697790058,'2024-07-03 05:54:30.454385','2024-07-03 05:54:30.454486',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032228433691654,1,8348143697790058,'2024-07-03 05:54:30.454385','2024-07-03 05:54:30.454486',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032228433691655,2,8348143697790058,'2024-07-03 05:54:30.454385','2024-07-03 05:54:30.454486',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032230637274117,0,8493189815600133,'2024-07-03 05:55:04.078835','2024-07-03 05:55:04.078935',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032230637274118,1,8493189815600133,'2024-07-03 05:55:04.078836','2024-07-03 05:55:04.078935',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032230637274119,2,8493189815600133,'2024-07-03 05:55:04.078836','2024-07-03 05:55:04.078936',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032231368459269,0,8493189914559493,'2024-07-03 05:55:15.235046','2024-07-03 05:55:15.235233',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032231368459270,1,8493189914559493,'2024-07-03 05:55:15.235047','2024-07-03 05:55:15.235233',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032231368459271,2,8493189914559493,'2024-07-03 05:55:15.235047','2024-07-03 05:55:15.235233',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032234021946373,0,8348143697790079,'2024-07-03 05:55:55.724068','2024-07-03 05:55:55.724156',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032234550297605,0,8348143697790082,'2024-07-03 05:56:03.786827','2024-07-03 05:56:03.786917',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032235196548101,0,8348143697790085,'2024-07-03 05:56:13.647496','2024-07-03 05:56:13.647586',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032235798430725,0,8348143697790088,'2024-07-03 05:56:22.831782','2024-07-03 05:56:22.831868',0);
INSERT INTO `role_permission_setting` (`id`,`role_type`,`permission_id`,`create_at`,`update_at`,`is_delete`) VALUES (9032236116935685,0,8348143697790094,'2024-07-03 05:56:27.691422','2024-07-03 05:56:27.691529',0);
COMMIT;