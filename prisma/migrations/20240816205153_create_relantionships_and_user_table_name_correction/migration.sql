/*
  Warnings:

  - You are about to drop the column `email` on the `check_ins` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `check_ins` table. All the data in the column will be lost.
  - You are about to drop the column `password_hash` on the `check_ins` table. All the data in the column will be lost.
  - You are about to drop the `CheckIn` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `gym_id` to the `check_ins` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `check_ins` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "check_ins_email_key";

-- AlterTable
ALTER TABLE "check_ins" DROP COLUMN "email",
DROP COLUMN "name",
DROP COLUMN "password_hash",
ADD COLUMN     "gym_id" TEXT NOT NULL,
ADD COLUMN     "user_id" TEXT NOT NULL,
ADD COLUMN     "validated_at" TIMESTAMP(3);

-- DropTable
DROP TABLE "CheckIn";

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "check_ins" ADD CONSTRAINT "check_ins_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "check_ins" ADD CONSTRAINT "check_ins_gym_id_fkey" FOREIGN KEY ("gym_id") REFERENCES "gyms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
