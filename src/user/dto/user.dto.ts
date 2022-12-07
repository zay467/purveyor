import { Role } from '@prisma/client';
import {
  IsEmail,
  IsNotEmpty,
  IsString,
  IsEnum,
  IsBoolean,
  MinLength,
  IsOptional,
} from 'class-validator';

export class UserDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  @MinLength(8)
  password: string;

  @IsEnum(Role)
  @IsNotEmpty()
  role: Role;

  @IsOptional()
  @IsString()
  gate: string | null;

  @IsOptional()
  @IsString()
  description: string | null;

  @IsBoolean()
  is_active: boolean;
}
