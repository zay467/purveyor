/*
  Warnings:

  - Added the required column `note` to the `TickerTrx` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `TickerTrx` ADD COLUMN `note` VARCHAR(191) NOT NULL;
