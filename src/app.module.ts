import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { SaleModule } from './sale/sale.module';
import { MatchModule } from './match/match.module';
import { PrismaModule } from './prisma/prisma.module';
import { UserModule } from './user/user.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    AuthModule,
    SaleModule,
    MatchModule,
    PrismaModule,
    UserModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
