/*
 *  Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 *  Copyright (C) 2015 - Scilab Enterprises - Calixte DENIZET
 *
 *  This file must be used under the terms of the CeCILL.
 *  This source file is licensed as described in the file COPYING, which
 *  you should have received as part of this distribution.  The terms
 *  are also available at
 *  http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#ifndef __INFERENCE_CONSTRAINT_HXX__
#define __INFERENCE_CONSTRAINT_HXX__

#include <cmath>
#include <unordered_set>
#include <vector>

#include "GVN.hxx"
#include "tools.hxx"

namespace analysis
{

struct MPolyConstraint;
struct MPolyConstraintSet;

struct InferenceConstraint
{
    enum Result { TRUE, FALSE, DUNNO } ;

    virtual Result check(const std::vector<GVN::Value *> & values) const = 0;
    virtual MPolyConstraintSet getMPConstraints(const std::vector<GVN::Value *> & values) const = 0;
    virtual void applyConstraints(const std::vector<GVN::Value *> & values) const { }

    inline static std::vector<const MultivariatePolynomial *> getArgs(const std::vector<GVN::Value *> & values)
    {
        std::vector<const MultivariatePolynomial *> args;
        args.reserve(values.size());
        for (const auto value : values)
        {
            args.emplace_back(value->poly);
        }
        return args;
    }

    inline static void applyEquality(GVN::Value & x, GVN::Value & y)
    {
        if (x != y)
        {
            if (x.poly->polynomial.size() < y.poly->polynomial.size())
            {
                y = x;
            }
            else
            {
                x = y;
            }
        }
    }
};

struct SameDimsConstraint : public InferenceConstraint
{
    virtual Result check(const std::vector<GVN::Value *> & values) const override;
    virtual MPolyConstraintSet getMPConstraints(const std::vector<GVN::Value *> & values) const override;
    virtual void applyConstraints(const std::vector<GVN::Value *> & values) const override;
};

struct EqualConstraint : public InferenceConstraint
{
    virtual Result check(const std::vector<GVN::Value *> & values) const override;
    virtual MPolyConstraintSet getMPConstraints(const std::vector<GVN::Value *> & values) const override;
    virtual void applyConstraints(const std::vector<GVN::Value *> & values) const override;
};

struct PositiveConstraint : public InferenceConstraint
{
    virtual Result check(const std::vector<GVN::Value *> & values) const override;
    virtual MPolyConstraintSet getMPConstraints(const std::vector<GVN::Value *> & values) const override;
    virtual void applyConstraints(const std::vector<GVN::Value *> & values) const override;
};

struct GreaterConstraint : public InferenceConstraint
{
    virtual Result check(const std::vector<GVN::Value *> & values) const override;
    virtual MPolyConstraintSet getMPConstraints(const std::vector<GVN::Value *> & values) const override;
    virtual void applyConstraints(const std::vector<GVN::Value *> & values) const override;
};

struct MPolyConstraint : public InferenceConstraint
{
    enum Kind { EQ0, NEQ0, GT0, GEQ0 };

    MultivariatePolynomial poly;
    Kind kind;

    MPolyConstraint(const MultivariatePolynomial & _poly, const Kind _kind) : poly(_poly), kind(_kind)
    {
        double common;
        if (poly.getCommonCoeff(common) && common != 1 && common != 0)
        {
            if (kind == EQ0)
            {
                poly /= common;
            }
            else
            {
                poly /= std::abs(common);
            }
        }
    }

    virtual Result check(const std::vector<GVN::Value *> & values) const override;
    virtual MPolyConstraintSet getMPConstraints(const std::vector<GVN::Value *> & values) const override;
    virtual void applyConstraints(const std::vector<GVN::Value *> & values) const override;

    struct Hash
    {
        inline std::size_t operator()(const MPolyConstraint & mpc) const
        {
            return tools::hash_combine(mpc.kind, mpc.poly.hash());
        }
    };

    struct Eq
    {
        inline bool operator()(const MPolyConstraint & L, const MPolyConstraint & R) const
        {
            return L.kind == R.kind && L.poly == R.poly;
        }
    };
};

struct MPolyConstraintSet : public InferenceConstraint
{
    std::unordered_set<MPolyConstraint, MPolyConstraint::Hash, MPolyConstraint::Eq> constraints;

    MPolyConstraintSet() { }
    MPolyConstraintSet(const unsigned int size)
    {
        constraints.reserve(size);
    }

    inline void add(MPolyConstraint && mpc)
    {
        constraints.emplace(std::move(mpc));
    }

    inline void add(MultivariatePolynomial && poly, MPolyConstraint::Kind kind)
    {
        constraints.emplace(std::move(poly), kind);
    }

    inline void add(const MultivariatePolynomial & poly, MPolyConstraint::Kind kind)
    {
        constraints.emplace(poly, kind);
    }

    inline void add(const MPolyConstraintSet & set)
    {
        constraints.insert(set.constraints.begin(), set.constraints.end());
    }

    virtual Result check(const std::vector<GVN::Value *> & values) const override;
    virtual MPolyConstraintSet getMPConstraints(const std::vector<GVN::Value *> & values) const override;
    virtual void applyConstraints(const std::vector<GVN::Value *> & values) const override;
};


} // namespace analysis

#endif // __INFERENCE_CONSTRAINT_HXX__