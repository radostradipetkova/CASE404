INSERT OR REPLACE INTO cases (id,title,subtitle,description,status,opened_at,location,subject) VALUES
('MP-404-017','The Vanishing of Mara Voss','A disappearance hidden inside a security incident','At 22:14 on October 17, forensic systems analyst Dr. Mara Voss vanished from the Meridian Civic Archive. Security footage was erased and her badge was used after she had already left the building. Investigate the people who had motive, access and opportunity.','open','2026-10-18T06:40:00','Meridian Civic Archive, North Quay','Dr. Mara Voss');

INSERT OR REPLACE INTO suspects (id,case_id,name,role,age,risk,alibi,background,motive,portrait,sort_order) VALUES
('s1','MP-404-017','Adrian Vale','Archive security chief',42,'high','Claims he supervised the west gate from 21:40 to 23:00. Gate camera confirms his presence only until 22:02.','Controls the archive cameras and security badges. Former police technical officer.','Mara was auditing unauthorized camera exports linked to his account.','AV',1),
('s2','MP-404-017','Elena Cross','Deputy archive director',38,'medium','Claims she attended a video meeting at home from 21:30 to 22:30. Meeting metadata shows continuous participation.','Approved the disputed Meridian redevelopment contract.','Mara had discovered irregularities in her procurement approvals.','EC',2),
('s3','MP-404-017','Noah Reed','Network engineer',29,'high','Claims he repaired the basement switch from 21:55 to 22:25. A signed work order and router logs place him there.','Maintains the archive network; his credentials can reset cameras.','He feared dismissal after a recent data leak.','NR',3),
('s4','MP-404-017','Iris Chen','Investigative journalist',34,'low','Claims she waited at the Quay Café from 21:45 to 22:35. A receipt and café camera support the claim.','Had arranged to receive documents from Mara.','A major exposé depended on obtaining Mara’s files.','IC',4);

INSERT OR REPLACE INTO evidence (id,case_id,title,category,description,source,recorded_at,unlock_key,suspect_id,sort_order) VALUES
('e1','MP-404-017','Damaged access log','Digital','Mara’s badge was recorded at the service exit at 22:19, five minutes after the building-wide camera blackout began. The record has a manual override flag.','Access-control export','2026-10-17T22:19:00','','s1',1),
('e2','MP-404-017','West gate camera still','Image','A still from 22:02 shows Adrian Vale leaving the west gate control room. No footage verifies his location after that.','Gate camera 02','2026-10-17T22:02:00','','s1',2),
('e3','MP-404-017','Network maintenance ticket','Document','Noah Reed’s repair ticket was countersigned at 22:27; independent switch telemetry confirms continuous work in basement rack B.','IT work-order system','2026-10-17T22:27:00','','s3',3),
('e4','MP-404-017','Café receipt','Document','Iris Chen paid for tea at 22:21. A separate café camera captures her at 22:24.','Quay Café','2026-10-17T22:24:00','','s4',4),
('e5','MP-404-017','Meeting attendance audit','Digital','Elena Cross maintained two-way audio and screen sharing from her home device between 21:31 and 22:32.','Meeting server','2026-10-17T22:32:00','','s2',5),
('e6','MP-404-017','Recovered camera command','Digital','At 22:14, terminal SEC-03 issued CAMERAS_DISABLE using a hardware security token assigned to Adrian Vale. The command was not issued from the basement network switch.','Security command journal','2026-10-17T22:14:00','p1','s1',6),
('e7','MP-404-017','Unsent emergency draft','Email','Mara wrote: “Vale found the duplicate ledger. If the cameras fail, check cold storage locker 27. He has my badge clone.” Draft saved at 22:09.','Recovered mail cache','2026-10-17T22:09:00','p2','s1',7),
('e8','MP-404-017','Locker 27 inventory','Physical','Locker 27 contains Mara’s encrypted audit drive and a security-token receipt bearing Adrian Vale’s employee ID. A handwritten note says: “I took the maintenance stairwell. Do not trust the badge exit.”','Cold storage locker 27','2026-10-18T08:11:00','p3','s1',8),
('e9','MP-404-017','Maintenance stairwell exit sensor','Digital','The emergency stairwell opened at 22:17 using a mechanical push bar. This route does not require a badge. Mara’s disappearance may have been a planned escape after she realized the danger.','Fire safety controller','2026-10-17T22:17:00','p3',NULL,9);

INSERT OR REPLACE INTO interviews (id,case_id,suspect_id,interviewer,conducted_at,transcript) VALUES
('i1','MP-404-017','s1','Det. Morgan','2026-10-18T09:15:00','DETECTIVE: Where were you at 22:14?\nVALE: West gate. All night.\nDETECTIVE: Camera 02 ends your coverage at 22:02.\nVALE: The system is unreliable. Ask Reed.\nDETECTIVE: Who carries the SEC-03 hardware token?\nVALE: Only I do, but it could be copied.'),
('i2','MP-404-017','s2','Det. Morgan','2026-10-18T10:10:00','DETECTIVE: Did Mara threaten to expose the contract?\nCROSS: She asked difficult questions. I answered them.\nDETECTIVE: Your video meeting lasted until 22:32?\nCROSS: Yes. The recording and attendees can verify it.'),
('i3','MP-404-017','s3','Det. Morgan','2026-10-18T11:00:00','DETECTIVE: Can you disable the cameras?\nREED: Technically, yes, with a security token I do not possess.\nDETECTIVE: You were in the basement?\nREED: Check switch rack B. It logged every diagnostic command.'),
('i4','MP-404-017','s4','Det. Morgan','2026-10-18T12:20:00','DETECTIVE: Why did Mara contact you?\nCHEN: She had proof that someone was selling archive records.\nDETECTIVE: Did she arrive at the café?\nCHEN: No. I waited until 22:35. I was scared something had happened.');

INSERT OR REPLACE INTO messages (id,case_id,channel,sender,recipient,subject,body,sent_at,unlock_key) VALUES
('m6','MP-404-017','email','Elena Cross','Mara Voss','Audit review','Please present the procurement discrepancies at tomorrow’s review. I expect documentation, not rumors.','2026-10-17T16:05:00',''),
('m4','MP-404-017','email','Noah Reed','Adrian Vale','Switch maintenance','Rack B diagnostics begin at 21:55. Please do not schedule camera resets during the maintenance window.','2026-10-17T19:40:00',''),
('m3','MP-404-017','sms','Unknown','Mara Voss','','Stop looking into the camera exports. Last warning.','2026-10-17T20:48:00',''),
('m1','MP-404-017','sms','Mara Voss','Iris Chen','','Meet at Quay Café. 22:00. If I am late, do not come to the archive.','2026-10-17T21:12:00',''),
('m2','MP-404-017','sms','Iris Chen','Mara Voss','','I am here. Are you safe?','2026-10-17T22:06:00',''),
('m5','MP-404-017','email','Mara Voss','Mara Voss','Emergency draft','Vale found the duplicate ledger. If the cameras fail, check cold storage locker 27. He has my badge clone.','2026-10-17T22:09:00','p2');

INSERT OR REPLACE INTO timeline_events (id,case_id,event_at,title,description,unlock_key) VALUES
('t1','MP-404-017','2026-10-17T20:48:00','Threatening message','Unknown sender warns Mara to stop investigating camera exports',''),
('t2','MP-404-017','2026-10-17T21:55:00','Basement maintenance begins','Noah starts a verifiable switch repair',''),
('t3','MP-404-017','2026-10-17T22:02:00','Vale leaves camera coverage','West gate still is the last independent record of Vale’s position',''),
('t4','MP-404-017','2026-10-17T22:09:00','Emergency draft saved','Mara records a warning about a cloned badge','p2'),
('t5','MP-404-017','2026-10-17T22:14:00','Cameras disabled','SEC-03 command issued with Vale’s hardware token','p1'),
('t6','MP-404-017','2026-10-17T22:17:00','Stairwell opened','Mechanical exit sensor triggers without a badge','p3'),
('t7','MP-404-017','2026-10-17T22:19:00','Badge exit registered','Mara’s badge is used at the service exit with manual override','');
