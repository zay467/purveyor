-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `role` ENUM('GateKeeper', 'ADMIN') NOT NULL DEFAULT 'GateKeeper',
    `gate` VARCHAR(191) NULL,
    `description` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Match` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `team1` VARCHAR(191) NOT NULL,
    `team1_img_url` VARCHAR(191) NULL,
    `team2` VARCHAR(191) NOT NULL,
    `team2_img_url` VARCHAR(191) NULL,
    `match_datetime` DATETIME(3) NOT NULL,
    `stadium` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `Match_stadium_match_datetime_idx`(`stadium`, `match_datetime`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TicketType` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Ticket` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `match_id` INTEGER NOT NULL,
    `ticket_type_id` INTEGER NOT NULL,
    `price` INTEGER NOT NULL,
    `sold_quantity` INTEGER NOT NULL DEFAULT 0,
    `issued_quantity` INTEGER NOT NULL,
    `status` ENUM('SoldOut', 'Active', 'Inactive') NOT NULL DEFAULT 'Active',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    INDEX `Ticket_match_id_status_idx`(`match_id`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Sale` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `source` VARCHAR(191) NULL,
    `ticket_code` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `nrc` VARCHAR(191) NOT NULL,
    `region` VARCHAR(191) NOT NULL,
    `township` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `checkin` BOOLEAN NOT NULL DEFAULT false,
    `match_meta_data` JSON NOT NULL,
    `ticket_meta_data` JSON NOT NULL,

    UNIQUE INDEX `Sale_ticket_code_key`(`ticket_code`),
    UNIQUE INDEX `Sale_phone_key`(`phone`),
    UNIQUE INDEX `Sale_nrc_key`(`nrc`),
    INDEX `Sale_ticket_code_checkin_idx`(`ticket_code`, `checkin`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_match_id_fkey` FOREIGN KEY (`match_id`) REFERENCES `Match`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_ticket_type_id_fkey` FOREIGN KEY (`ticket_type_id`) REFERENCES `TicketType`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
