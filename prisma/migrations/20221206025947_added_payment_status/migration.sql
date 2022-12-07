-- AlterTable
ALTER TABLE `Sale` ADD COLUMN `payment_status` ENUM('Success', 'Fail', 'Pending') NOT NULL DEFAULT 'Pending';
